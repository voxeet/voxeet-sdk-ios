//
//  ConferenceViewController.swift
//  VoxeetSDK Sample
//
//  Created by Coco on 28/04/16.
//  Copyright © 2016 Corentin Larroque. All rights reserved.
//

import UIKit
import VoxeetSDK

/*
 *  MARK: - User structure
 */

struct User {
    var userID: String
    var externalID: String?
    var avatarUrl: String?
    var name: String?
}

/*
 *  MARK: - Conference class
 */

class ConferenceViewController: UIViewController {
    // UI.
    @IBOutlet weak var conferenceIDLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var broadcastMessageTextView: UITextView!
    @IBOutlet weak var screenShareView: VideoRenderer!
    @IBOutlet weak var ownCameraView: VideoRenderer!
    @IBOutlet weak var ownCameraHandlerButton: UIButton!
    @IBOutlet weak var switchDeviceSpeakerButton: UIButton!
    
    // Current conference ID.
    var conferenceID: String?
    
    // Users' data.
    var users = [User]()
    
    /*
     *  MARK: Load / Unload
     */
    
    override func viewDidLoad() {
        // Setting label.
        conferenceIDLabel.text = conferenceID
        
        // Conference delegate.
        VoxeetSDK.shared.conference.delegate = self
        
        // Joining / Launching demo.
        if let confID = conferenceID {
            // Joining Conference.
            VoxeetSDK.shared.conference.join(conferenceID: confID, video: true, fail: { (error) in
                // Debug.
                print("[ERROR] \(#function) - Error: \(error)")
                
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            conferenceIDLabel.text = "Demo"
            
            // Creating Voxeet demo conference.
            VoxeetSDK.shared.conference.createDemo { (error) in
                if let error = error {
                    // Debug.
                    print("[ERROR] \(#function) - Error: \(error)")
                    
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
            // Hide own preview camera.
            ownCameraView.isHidden = true
            ownCameraHandlerButton.isHidden = true
        }
        
        // Select/Deselect the switchDeviceSpeakerButton when an audio session route is changed.
        NotificationCenter.default.addObserver(self, selector: #selector(audioSessionRouteChange), name: NSNotification.Name.AVAudioSessionRouteChange, object: nil)
    }
    
    deinit {
        // Debug.
        print("[DEBUG] \(#function)")
        
        NotificationCenter.default.removeObserver(self)
    }
    
    /*
     *  MARK: Actions
     */
    
    @IBAction func sendBroadcastMessage(_ sender: AnyObject) {
        // Alert view.
        let alertController = UIAlertController(title: "Send Message", message: "Please input the message:", preferredStyle: .alert)
        
        // Alert actions.
        let confirmAction = UIAlertAction(title: "Send", style: .default) { (_) in
            if let textField = alertController.textFields?[0],
                let message = textField.text {
                // Sending a broadcast message.
                VoxeetSDK.shared.conference.sendBroadcastMessage(message, completion: { (error) in
                    if let error = error {
                        // Debug.
                        print("[ERROR] \(#function) - Error: \(error)")
                    }
                })
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        // Alert textField.
        alertController.addTextField { (textField) in
            textField.placeholder = "Message"
            textField.clearButtonMode = .whileEditing
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func switchDeviceSpeaker(_ button: UIButton) {
        VoxeetSDK.shared.conference.switchDeviceSpeaker()
    }
    
    @IBAction func hangUp(_ sender: AnyObject) {
        VoxeetSDK.shared.conference.leave { (error) in
            if let error = error {
                // Debug.
                print("[ERROR] \(#function) - Error: \(error)")
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func switchCamera(_ sender: AnyObject) {
        VoxeetSDK.shared.conference.flipCamera()
    }
    
    @IBAction func ownVideo(_ button: UIButton) {
        guard let userID = VoxeetSDK.shared.conference.getOwnUser()?.userID else {
            return
        }
        
        button.isEnabled = false
        if button.isSelected {
            VoxeetSDK.shared.conference.stopVideo(userID: userID, completion: { _ in
                button.isEnabled = true
            })
        } else {
            VoxeetSDK.shared.conference.startVideo(userID: userID, completion: { _ in
                button.isEnabled = true
            })
        }
        button.isSelected = !button.isSelected
    }
    
    /*
     *  MARK: Observer
     */
    
    dynamic func audioSessionRouteChange() {
        DispatchQueue.main.async {
            self.switchDeviceSpeakerButton.isSelected = AVAudioSession.sharedInstance().currentRoute.outputs.first?.portType == AVAudioSessionPortBuiltInSpeaker
        }
    }
}

/*
 *  MARK: - Voxeet SDK conference delegate
 */

extension ConferenceViewController: VTConferenceDelegate {
    func participantAdded(userID: String, userInfo: [String: Any], stream: MediaStream) {
        if VoxeetSDK.shared.conference.getOwnUser()?.userID == userID {
            // Attaching own user's video stream.
            ownCameraView.isHidden = false
            VoxeetSDK.shared.conference.attachMediaStream(stream, renderer: ownCameraView)
        } else {
            // Save the user and refresh the tableView.
            users.append(User(userID: userID, externalID: userInfo["externalId"] as? String, avatarUrl: userInfo["avatarUrl"] as? String, name: userInfo["name"] as? String))
            tableView.reloadData()
            
            if let index = self.users.index(where: { $0.userID == userID }), let cell = self.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? ConferenceTableViewCell {
                // Attaching user's video stream.
                cell.userVideoView.isHidden = false
                VoxeetSDK.shared.conference.attachMediaStream(stream, renderer: cell.userVideoView)
            }
        }
    }
    
    func participantUpdated(userID: String, userInfo: [String: Any], stream: MediaStream) {
        var renderer: VideoRenderer?
        
        // Get the video renderer.
        if VoxeetSDK.shared.conference.getOwnUser()?.userID == userID {
            renderer = ownCameraView
        } else if let index = self.users.index(where: { $0.userID == userID }), let cell = self.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? ConferenceTableViewCell {
            renderer = cell.userVideoView
            renderer?.isHidden = !stream.hasVideo
        }
        
        // Attach/Unattach the stream.
        if let renderer = renderer {
            if stream.hasVideo {
                VoxeetSDK.shared.conference.attachMediaStream(stream, renderer: renderer)
            } else {
                VoxeetSDK.shared.conference.unattachMediaStream(stream, renderer: renderer)
            }
        }
    }
    
    func participantRemoved(userID: String, userInfo: [String: Any]) {
        users = users.filter({ $0.userID != userID })
        tableView.reloadData()
    }
    
    func messageReceived(userID: String, userInfo: [String: Any], message: String) {
        if let name = users.filter({ $0.userID == userID }).first?.name {
            broadcastMessageTextView.text = "\(name): \(message)"
        } else {
            broadcastMessageTextView.text = "\(userID): \(message)"
        }
    }
    
    func screenShareStarted(userID: String, stream: MediaStream) {
        // Attaching a video stream to a renderer.
        VoxeetSDK.shared.conference.attachMediaStream(stream, renderer: screenShareView)
    }
    
    func screenShareStopped(userID: String) {}
}

/*
 *  MARK: - Conference tableView dataSource & delegate
 */

extension ConferenceViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! ConferenceTableViewCell
        
        // Getting the current user.
        let user = users[(indexPath as NSIndexPath).row]
        
        // Setting up the cell.
        cell.setUp(user)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Mutes a user.
        let user = users[(indexPath as NSIndexPath).row]
        VoxeetSDK.shared.conference.muteUser(!VoxeetSDK.shared.conference.isUserMuted(userID: user.userID), userID: user.userID)
        
        // Update background color.
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.backgroundColor = VoxeetSDK.shared.conference.isUserMuted(userID: user.userID) ? UIColor.red : UIColor.white
        }
    }
}

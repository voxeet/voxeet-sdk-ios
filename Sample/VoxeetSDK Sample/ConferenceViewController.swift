//
//  ConferenceViewController.swift
//  VoxeetSDK Sample
//
//  Created by Coco on 28/04/16.
//  Copyright © 2016 Corentin Larroque. All rights reserved.
//

import UIKit
import VoxeetSDK
import AVKit

/*
 *  MARK: - Conference class
 */

class ConferenceViewController: UIViewController {
    // UI.
    @IBOutlet weak var conferenceIDLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var broadcastMessageTextView: UITextView!
    @IBOutlet weak var screenShareView: VTVideoView!
    @IBOutlet weak var ownCameraView: VTVideoView!
    @IBOutlet weak var ownCameraHandlerButton: UIButton!
    @IBOutlet weak var switchDeviceSpeakerButton: UIButton!
    @IBOutlet weak var startScreenShareButton: UIButton!
    @IBOutlet weak var videoPresentationView: UIView!
    @IBOutlet weak var filePresentationImageView: UIImageView!
    
    // Current conference ID.
    var conferenceID: String?
    
    private var player: AVPlayer?
    
    /*
     *  MARK: Load / Unload
     */
    
    override func viewDidLoad() {
        // Setting label.
        conferenceIDLabel.text = conferenceID
        
        // Conference delegate.
        VoxeetSDK.shared.conference.delegate = self
        
        // Joining / launching demo.
        if let confID = conferenceID {
            // Joining Conference.
            VoxeetSDK.shared.conference.join(conferenceID: confID, video: true, userInfo: nil, success: nil, fail: { (error) in
                // Debug.
                print("[ERROR] \(#function) - Error: \(error)")
                
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            conferenceIDLabel.text = "Demo"
            
            // Creating Voxeet demo conference.
            VoxeetSDK.shared.conference.demo { (error) in
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
        
        // Screen share feature is only available above (or equal to) iOS 11.
        if #available(iOS 11.0, *) {} else {
            startScreenShareButton.isHidden = true
        }
        
        // Select / deselect the switchDeviceSpeakerButton when an headset is plugged.
        NotificationCenter.default.addObserver(self, selector: #selector(audioSessionRouteChange), name: AVAudioSession.routeChangeNotification, object: nil)
        
        // Force the device screen to never going to sleep mode.
        UIApplication.shared.isIdleTimerDisabled = true
        
        // File presentation observers.
        NotificationCenter.default.addObserver(self, selector: #selector(filePresentationStartedUpdated), name: .VTFilePresentationStarted, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(filePresentationStartedUpdated), name: .VTFilePresentationUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(filePresentationStopped), name: .VTFilePresentationStopped, object: nil)
        
        // Video presentation observers.
        NotificationCenter.default.addObserver(self, selector: #selector(videoPresentationStarted), name: .VTVideoPresentationStarted, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(videoPresentationStopped), name: .VTVideoPresentationStopped, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(videoPresentationPlay), name: .VTVideoPresentationPlay, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(videoPresentationPause), name: .VTVideoPresentationPause, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(videoPresentationSeek), name: .VTVideoPresentationSeek, object: nil)
    }
    
    deinit {
        // Debug.
        print("[DEBUG] \(#function)")
        
        // Remove observers.
        NotificationCenter.default.removeObserver(self)
        // Reset: Force the device screen to never going to sleep mode.
        UIApplication.shared.isIdleTimerDisabled = false
        
        player?.pause()
        player = nil
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
                VoxeetSDK.shared.conference.broadcast(message: message, completion: { (error) in
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
    
    @IBAction func startScreenShare(_ sender: UIButton) {
        if #available(iOS 11.0, *) {
            if sender.isSelected {
                guard VoxeetSDK.shared.conference.screenShareMediaStream() == nil else {
                    // Debug.
                    print("[ERROR] \(#function) - Error: Only one screen share allowed.")
                    return
                }
                
                VoxeetSDK.shared.conference.startScreenShare(completion: { (error) in
                    if let error = error {
                        // Debug.
                        print("[ERROR] \(#function) - Error: \(error)")
                    }
                })
            } else {
                VoxeetSDK.shared.conference.stopScreenShare(completion: { (error) in
                    if let error = error {
                        // Debug.
                        print("[ERROR] \(#function) - Error: \(error)")
                    }
                })
            }
            
            sender.isSelected = !sender.isSelected
            sender.setTitle(sender.isSelected ? "Start screen share" : "Stop screen share", for: .normal)
        }
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
        guard let userID = VoxeetSDK.shared.session.user?.id else {
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
    
    @objc func audioSessionRouteChange() {
        DispatchQueue.main.async {
            self.switchDeviceSpeakerButton.isSelected = AVAudioSession.sharedInstance().currentRoute.outputs.first?.portType == AVAudioSession.Port.builtInSpeaker
        }
    }
}

/*
 *  MARK: - Voxeet SDK conference delegate
 */

extension ConferenceViewController: VTConferenceDelegate {
    func participantJoined(userID: String, stream: RTCMediaStream) {
        if VoxeetSDK.shared.session.user?.id == userID {
            // Attaching own user's video stream.
            if !stream.videoTracks.isEmpty {
                ownCameraView.isHidden = false
                VoxeetSDK.shared.conference.attachMediaStream(stream, renderer: ownCameraView)
            }
        } else {
            tableView.reloadData()
        }
    }
    
    func participantUpdated(userID: String, stream: RTCMediaStream) {
        let users = VoxeetSDK.shared.conference.users.filter({ $0.asStream })
        
        // Get the video renderer.
        if VoxeetSDK.shared.session.user?.id == userID {
            ownCameraView.isHidden = stream.videoTracks.isEmpty
            
            // Attaching own user's video stream.
            if !stream.videoTracks.isEmpty {
                VoxeetSDK.shared.conference.attachMediaStream(stream, renderer: ownCameraView)
            }
        } else if let index = users.index(where: { $0.id == userID }) {
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }
    }
    
    func participantLeft(userID: String) {
        tableView.reloadData()
    }
    
    func messageReceived(userID: String, message: String) {
        if let name = VoxeetSDK.shared.conference.user(userID: userID)?.name {
            broadcastMessageTextView.text = "\(name): \(message)"
        } else {
            broadcastMessageTextView.text = "\(userID): \(message)"
        }
    }
    
    func screenShareStarted(userID: String, stream: RTCMediaStream) {
        // Attaching a video stream to a renderer.
        VoxeetSDK.shared.conference.attachMediaStream(stream, renderer: screenShareView)
        
        screenShareView.alpha = 1
    }
    
    func screenShareStopped(userID: String) {
        screenShareView.alpha = 0
    }
}

/*
 *  MARK: - Conference tableView dataSource & delegate
 */

extension ConferenceViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VoxeetSDK.shared.conference.users.filter({ $0.asStream }).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! ConferenceTableViewCell
        
        // Getting the current user.
        let users = VoxeetSDK.shared.conference.users.filter({ $0.asStream })
        let user = users[indexPath.row]
        
        // Setting up the cell.
        cell.setUp(user: user)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Getting the current user.
        let users = VoxeetSDK.shared.conference.users.filter({ $0.asStream })
        let user = users[(indexPath as NSIndexPath).row]
        
        // Mute a user.
        if let userID = user.id {
            let isMuted = VoxeetSDK.shared.conference.toggleMute(userID: userID)
            
            // Update background color.
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.backgroundColor = isMuted ? UIColor.red : UIColor.white
            }
        }
    }
}

/*
 *  MARK: - Conference file presentation
 */

extension ConferenceViewController {
    @objc func filePresentationStartedUpdated(notification: Notification) {
        guard let userInfo = notification.userInfo?.values.first as? Data else {
            return
        }
        
        do {
            if let json = try JSONSerialization.jsonObject(with: userInfo) as? [String: Any] {
                if let fileID = json["fileId"] as? String, let page = json["position"] as? Int {
                    if let url = VoxeetSDK.shared.filePresentation.getImage(fileID: fileID, page: page) {
                        let data = try Data(contentsOf: url)
                        let image = UIImage(data: data)
                        filePresentationImageView.image = image
                        filePresentationImageView.isHidden = false
                    }
                }
            }
        } catch {}
    }
    
    @objc func filePresentationStopped(notification: Notification) {
        filePresentationImageView.image = nil
        filePresentationImageView.isHidden = true
    }
}

/*
 *  MARK: - Conference video presentation
 */

extension ConferenceViewController {
    @objc func videoPresentationStarted(notification: Notification) {
        guard let userInfo = notification.userInfo?.values.first as? Data else {
            return
        }
        
        do {
            if let json = try JSONSerialization.jsonObject(with: userInfo) as? [String: Any] {
                if let url = URL(string: json["url"] as? String ?? ""), let timestamp = json["timestamp"] as? Int {
                    player = AVPlayer(url: url)
                    let playerLayer = AVPlayerLayer(player: player)
                    playerLayer.frame = videoPresentationView.bounds
                    playerLayer.backgroundColor = UIColor.black.cgColor
                    videoPresentationView.layer.addSublayer(playerLayer)
                    
                    player?.play()
                    player?.seek(to: CMTimeMakeWithSeconds(Double(timestamp) / 1000, preferredTimescale: 1000))
                    
                    videoPresentationView.isHidden = false
                }
            }
        } catch {}
    }
    
    @objc func videoPresentationStopped(notification: Notification) {
        player?.pause()
        player = nil
        videoPresentationView.isHidden = true
    }
    
    @objc func videoPresentationPlay(notification: Notification) {
        guard let userInfo = notification.userInfo?.values.first as? Data else {
            return
        }
        
        do {
            if let json = try JSONSerialization.jsonObject(with: userInfo) as? [String: Any] {
                if let timestamp = json["timestamp"] as? Int {
                    player?.play()
                    player?.seek(to: CMTimeMakeWithSeconds(Double(timestamp) / 1000, preferredTimescale: 1000))
                }
            }
        } catch {}
    }
    
    @objc func videoPresentationPause(notification: Notification) {
        player?.pause()
    }
    
    @objc func videoPresentationSeek(notification: Notification) {
        guard let userInfo = notification.userInfo?.values.first as? Data else {
            return
        }
        
        do {
            if let json = try JSONSerialization.jsonObject(with: userInfo) as? [String: Any] {
                if let timestamp = json["timestamp"] as? Int {
                    player?.seek(to: CMTimeMakeWithSeconds(Double(timestamp) / 1000, preferredTimescale: 1000))
                }
            }
        } catch {}
    }
}

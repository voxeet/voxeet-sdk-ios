//
//  Conference.swift
//  VoxeetSDK Sample
//
//  Created by Coco on 28/04/16.
//  Copyright © 2016 Corentin Larroque. All rights reserved.
//

import UIKit
import VoxeetSDK

/*
 *   MARK: - Conference class
 */

class Conference: UIViewController {
    // UI.
    @IBOutlet weak var conferenceIDLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var broadcastMessageTextView: UITextView!
    
    // Current conference ID.
    var conferenceID: String?
    
    // Users.
    var users = [String]()
    
    /*
     *   MARK: Load
     */
    
    override func viewDidLoad() {
        // Setting label.
        conferenceIDLabel.text = conferenceID
        
        // Joining / Launching demo.
        if let confID = conferenceID {
            // Joining Conference.
            VoxeetSDK.sharedInstance.joinConference(conferenceAlias: confID) { (error) in
                if error != nil {
                    // Debug.
                    print("::DEBUG:: <joinConference> \(error)")

                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            }
        } else {
            conferenceIDLabel.text = "Demo"
            
            // Creating Voxeet demo conference.
            VoxeetSDK.sharedInstance.createDemoConference { (error) in
                if error != nil {
                    // Debug.
                    print("::DEBUG:: <createDemoConference> \(error)")
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            }
        }
        
        // Conference delegate.
        VoxeetSDK.sharedInstance.conferenceDelegate = self
    }
    
    /*
     *   MARK: Action
     */
    
    @IBAction func sendBroadcastMessage(sender: AnyObject) {
        // Alert view.
        let alertController = UIAlertController(title: "Send Message", message: "Please input the message:", preferredStyle: .Alert)
        
        // Alert actions.
        let confirmAction = UIAlertAction(title: "Send", style: .Default) { (_) in
            if let textField = alertController.textFields?[0],
                let message = textField.text {
                // Sending a broadcast message.
                VoxeetSDK.sharedInstance.sendBroadcastMessage(message, completion: { (error) in
                    // Debug.
                    print("::DEBUG:: <sendBroadcastMessage> \(error)")
                })
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
        
        // Alert textField.
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Message"
            textField.clearButtonMode = .WhileEditing
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func hangUp(sender: AnyObject) {
        VoxeetSDK.sharedInstance.leaveConference { (error) in
            // Debug.
            print("::DEBUG:: <leaveConference> \(error)")
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}

extension Conference: VTConferenceDelegate {
    func userDidJoin(userID: String) {
        users.append(userID)
        tableView.reloadData()
    }
    
    func userDidLeft(userID: String) {
        users = users.filter({ $0 != userID })
        tableView.reloadData()
    }
    
    func messageReceived(userID: String, message: String) {
        broadcastMessageTextView.text = "\(userID): \(message)"
    }
}

/*
 *   MARK: - Conference tableView dataSource & delegate
 */

extension Conference: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableViewCell", forIndexPath: indexPath) as! ConferenceTableViewCell
        
        let user = users[indexPath.row]
        
        cell.userLabel.text = user
        
        if let position = VoxeetSDK.sharedInstance.getUserPosition(user) {
            cell.angleSlider.setValue(position.angle, animated: false)
            cell.distanceSlider.setValue(position.distance, animated: false)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        // Mutes a user.
        let user = users[indexPath.row]
        VoxeetSDK.sharedInstance.muteUser(user, mute: !VoxeetSDK.sharedInstance.isUserMuted(user))
    }
}

/*
 *   MARK: - Conference tableView cell
 */

class ConferenceTableViewCell: UITableViewCell {
    // UI.
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var angleSlider: UISlider!
    @IBOutlet weak var distanceSlider: UISlider!
    
    /*
     *   MARK: Action
     */
    
    @IBAction func angle(sender: UISlider) {
        // Debug.
        print("::DEBUG:: <angle> \(sender.value)")
        
        // Setting user position.
        VoxeetSDK.sharedInstance.setUserAngle(userLabel.text!, angle: sender.value)
    }
    
    @IBAction func distance(sender: UISlider) {
        // Debug.
        print("::DEBUG:: <distance> \(sender.value)")
        
        // Setting user position.
        VoxeetSDK.sharedInstance.setUserDistance(userLabel.text!, distance: sender.value)
    }
}
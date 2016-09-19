//
//  ConferenceTableViewCell.swift
//  VoxeetSDK Sample
//
//  Created by Coco on 31/08/16.
//  Copyright © 2016 Corentin Larroque. All rights reserved.
//

import Foundation
import VoxeetSDK

class ConferenceTableViewCell: UITableViewCell {
    // UI.
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var angleSlider: UISlider!
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var userVideoView: VideoRenderer!
    
    // Data.
    var currentUser: User!
    
    /*
     *  MARK: Set Up
     */
    
    func setUp(currentUser: User) {
        self.currentUser = currentUser
        
        // Cell label.
        if let name = currentUser.name {
            userLabel.text = name
        } else {
            userLabel.text = currentUser.userID
        }
        
        // Cell avatar.
        if let avatarURL = currentUser.avatarUrl {
            let imgURL: NSURL = NSURL(string: avatarURL)!
            let request: NSURLRequest = NSURLRequest(URL: imgURL)
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
                if error == nil {
                    if let data = data {
                        dispatch_async(dispatch_get_main_queue()) {
                            self.userPhoto.image = UIImage(data: data)
                        }
                    }
                } else {
                    // Debug.
                    print("::DEBUG:: <avatar> \(error?.localizedDescription)")
                }
            }
            task.resume()
        }
        
        // Slider update.
        let position = VoxeetSDK.sharedInstance.conference.getUserPosition(currentUser.userID)
        self.angleSlider.setValue(Float(position.angle), animated: false)
        self.distanceSlider.setValue(Float(position.distance), animated: false)
        
        // Background update.
        self.backgroundColor = VoxeetSDK.sharedInstance.conference.isUserMuted(currentUser.userID) ? UIColor.redColor() : UIColor.whiteColor()
    }
    
    /*
     *  MARK: Action
     */
    
    @IBAction func angle(sender: UISlider) {
        // Debug.
        print("::DEBUG:: <angle> \(sender.value)")
        
        // Setting user position.
        VoxeetSDK.sharedInstance.conference.setUserAngle(currentUser.userID, angle: Double(sender.value))
    }
    
    @IBAction func distance(sender: UISlider) {
        // Debug.
        print("::DEBUG:: <distance> \(sender.value)")
        
        // Setting user position.
        VoxeetSDK.sharedInstance.conference.setUserDistance(currentUser.userID, distance: Double(sender.value))
    }
}
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
    var user: VTUser!
    
    /*
     *  MARK: Init
     */
    
    func setUp(user: VTUser) {
        self.user = user
        
        // Cell label.
        if let name = user.externalName() {
            userLabel.text = name
        } else {
            userLabel.text = user.id
        }
        
        // Cell avatar.
        if let photoURL = URL(string: user.externalPhotoURL() ?? "") {
            let request = URLRequest(url: photoURL)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let error = error {
                    // Debug.
                    print("[ERROR] \(#function) - Error: \(error.localizedDescription)")
                } else {
                    if let data = data {
                        DispatchQueue.main.async {
                            self.userPhoto.image = UIImage(data: data)
                        }
                    }
                }
            })
            task.resume()
        }
        
        // Slider update.
        self.angleSlider.setValue(Float(user.conferenceInfo.angle), animated: false)
        self.distanceSlider.setValue(Float(user.conferenceInfo.distance), animated: false)
        
        // Background update.
        self.backgroundColor = user.conferenceInfo.mute ? UIColor.red : UIColor.white
    }
    
    /*
     *  MARK: Action
     */
    
    @IBAction func angle(_ sender: UISlider) {
        // Debug.
        print("[DEBUG] \(#function) - Angle: \(sender.value)")
        
        // Setting user position.
        if let userID = user.id {
            VoxeetSDK.shared.conference.userPosition(userID: userID, angle: Double(sender.value))
        }
    }
    
    @IBAction func distance(_ sender: UISlider) {
        // Debug.
        print("[DEBUG] \(#function) - Distance: \(sender.value)")
        
        // Setting user position.
        if let userID = user.id {
            VoxeetSDK.shared.conference.userPosition(userID: userID, distance: Double(sender.value))
        }
    }
}

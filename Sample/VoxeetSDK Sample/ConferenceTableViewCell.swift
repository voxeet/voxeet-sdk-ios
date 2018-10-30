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
    @IBOutlet weak private var userLabel: UILabel!
    @IBOutlet weak private var userPhoto: UIImageView!
    @IBOutlet weak private var angleSlider: UISlider!
    @IBOutlet weak private var distanceSlider: UISlider!
    @IBOutlet weak private var userVideoView: VTVideoView!
    
    // Data.
    private var user: VTUser!
    
    /*
     *  MARK: Init
     */
    
    func setUp(user: VTUser) {
        self.user = user
        
        // Cell label.
        userLabel.text = user.name ?? user.id
        
        // Cell avatar.
        if let photoURL = URL(string: user.avatarURL ?? "") {
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
        angleSlider.setValue(Float(user.angle), animated: false)
        distanceSlider.setValue(Float(user.distance), animated: false)
        
        // Background update.
        backgroundColor = user.mute ? UIColor.red : UIColor.white
        
        // Update renderer's stream.
        if let userID = user.id, let stream = VoxeetSDK.shared.conference.mediaStream(userID: userID), !stream.videoTracks.isEmpty {
            VoxeetSDK.shared.conference.attachMediaStream(stream, renderer: userVideoView)
            userVideoView.isHidden = false
        } else {
            userVideoView.isHidden = true
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Unattach the old stream before reusing the cell.
        if let userID = user?.id, let stream = VoxeetSDK.shared.conference.mediaStream(userID: userID), !stream.videoTracks.isEmpty {
            VoxeetSDK.shared.conference.unattachMediaStream(stream, renderer: userVideoView)
        }
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

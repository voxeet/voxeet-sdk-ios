//
//  ConferenceTableViewCell.swift
//  VoxeetSDK Sample
//
//  Created by Corentin Larroque on 31/08/16.
//  Copyright © 2016 Voxeet. All rights reserved.
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
    private var participant: VTParticipant!
    
    /*
     *  MARK: Init
     */
    
    func setUp(participant: VTParticipant) {
        self.participant = participant
        
        // Cell label.
        userLabel.text = participant.info.name ?? participant.id
        
        // Cell avatar.
        if let photoURL = URL(string: participant.info.avatarURL ?? "") {
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
        angleSlider.setValue(Float(participant.angle), animated: false)
        distanceSlider.setValue(Float(participant.distance), animated: false)
        
        // Background update.
        backgroundColor = participant.mute ? UIColor.red : UIColor.white
        
        // Update renderer's stream.
        if let stream = participant.streams.first(where: { $0.type == .Camera }), !stream.videoTracks.isEmpty {
            userVideoView.attach(participant: participant, stream: stream)
            userVideoView.isHidden = false
        } else {
            userVideoView.isHidden = true
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Unattach the old stream before reusing the cell.
        if let stream = participant.streams.first(where: { $0.type == .Camera }), !stream.videoTracks.isEmpty {
            userVideoView.unattach()
        }
    }
    
    /*
     *  MARK: Action
     */
    
    @IBAction func angle(_ sender: UISlider) {
        // Setting user position.
        VoxeetSDK.shared.conference.position(participant: participant, angle: Double(sender.value))
        
        // Debug.
        print("[Sample] \(String(describing: ConferenceTableViewCell.self)).\(#function).\(#line) - Angle: \(sender.value)")
    }
    
    @IBAction func distance(_ sender: UISlider) {
        // Setting user position.
        VoxeetSDK.shared.conference.position(participant: participant, distance: Double(sender.value))
        
        // Debug.
        print("[Sample] \(String(describing: ConferenceTableViewCell.self)).\(#function).\(#line) - Distance: \(sender.value)")
    }
}

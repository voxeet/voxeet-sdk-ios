//
//  AudioEngineDemo.swift
//  VoxeetSDK Sample
//
//  Created by Coco on 10/05/16.
//  Copyright © 2016 Corentin Larroque. All rights reserved.
//

import UIKit
import VoxeetSDK

class AudioEngineDemo: UIViewController {
    var elephantSound: VTAudioSound?
    
    override func viewDidLoad() {
        // Initializes VTAudioSound.
        if let path = Bundle.main.path(forResource: "Elephant-mono", ofType: "mp3") {
            do {
                elephantSound = try VTAudioSound(url: URL(fileURLWithPath: path))
            } catch let error {
                // Debug.
                print("::DEBUG:: <AudioEngineDemo> \(error)")
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // Stopping the current sound.
        elephantSound?.stop()
    }
    
    /*
     *  MARK: Actions
     */
    
    @IBAction func angle(_ sender: UISlider) {
        // Updating sound spatialization.
        elephantSound?.angle = Double(sender.value)
    }
    
    @IBAction func distance(_ sender: UISlider) {
        // Updating sound spatialization.
        elephantSound?.distance = Double(sender.value)
    }
    
    @IBAction func loop(_ sender: UISwitch) {
        // Playing in loop the current sound.
        elephantSound?.loop = sender.isOn
        
        if sender.isOn == false {
            // Stopping the current sound.
            elephantSound?.stop()
        }
    }
    
    @IBAction func play(_ sender: AnyObject) {
        // Playing sound.
        do {
            try elephantSound?.play() {
                // Debug.
                print("::DEBUG:: The sound has finished being played.")
            }
        } catch let error {
            // Debug.
            print("::DEBUG:: <play> \(error)")
        }
    }
}

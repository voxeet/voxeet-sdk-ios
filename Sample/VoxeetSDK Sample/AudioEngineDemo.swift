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
        do {
            elephantSound = try VTAudioSound(forResource: "Elephant-mono", ofType: "mp3")
        } catch let error {
            // Debug.
            print("[ERROR] \(#function) - Error: \(error)")
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
        elephantSound?.angle = sender.value
    }
    
    @IBAction func distance(_ sender: UISlider) {
        // Updating sound spatialization.
        elephantSound?.distance = sender.value
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
        try? elephantSound?.play()
    }
}

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
        if let path = NSBundle.mainBundle().pathForResource("Elephant-mono", ofType: "mp3") {
            do {
                elephantSound = try VTAudioSound(url: NSURL(fileURLWithPath: path))
            } catch let error {
                // Debug.
                print("::DEBUG:: <AudioEngineDemo> \(error)")
            }
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        // Stopping the current sound.
        elephantSound?.stop()
    }
    
    /*
     *  MARK: Actions
     */
    
    @IBAction func angle(sender: UISlider) {
        // Updating sound spatialization.
        elephantSound?.angle = Double(sender.value)
    }
    
    @IBAction func distance(sender: UISlider) {
        // Updating sound spatialization.
        elephantSound?.distance = Double(sender.value)
    }
    
    @IBAction func loop(sender: UISwitch) {
        // Playing in loop the current sound.
        elephantSound?.loop = sender.on
        
        if sender.on == false {
            // Stopping the current sound.
            elephantSound?.stop()
        }
    }
    
    @IBAction func play(sender: AnyObject) {
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
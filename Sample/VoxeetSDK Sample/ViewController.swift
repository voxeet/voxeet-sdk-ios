//
//  ViewController.swift
//  VoxeetSDK Sample
//
//  Created by Coco on 22/04/16.
//  Copyright © 2016 Corentin Larroque. All rights reserved.
//

import UIKit
import VoxeetSDK

// NSUserDefaults.
let VTConfID = "VTConfID"

class ViewController: UIViewController {
    
    /*
     *  MARK: Load
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*
     *  MARK: Action
     */
    
    @IBAction func createConference(sender: AnyObject) {
        // Conference creation.
        VoxeetSDK.sharedInstance.conference.create(success: { (confID, confAlias) in
            // Debug.
            print("::DEBUG:: <createConference> \(confID), \(confAlias)")
            
            // Start the conference viewController.
            self.presentConferenceVC(confAlias)
            
            }, fail: { (error) in
                // Debug.
                print("::DEBUG:: <createConference> \(error)")
        })
    }
    
    @IBAction func joinConference(sender: AnyObject) {
        // Alert view.
        let alertController = UIAlertController(title: "Conference ID", message: "Please input the conference ID:", preferredStyle: .Alert)
        
        // Alert actions.
        let confirmAction = UIAlertAction(title: "Join", style: .Default) { (_) in
            if let textField = alertController.textFields?[0],
                let confID = textField.text {
                
                // Start the conference viewController.
                self.presentConferenceVC(confID)
                
                // Save the current conference ID.
                NSUserDefaults.standardUserDefaults().setObject(confID, forKey: VTConfID)
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
        
        // Alert textField.
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Conference ID"
            textField.keyboardType = .NumberPad
            textField.clearButtonMode = .WhileEditing
            
            // Setting the textfield text by the previous text saved.
            let text = NSUserDefaults.standardUserDefaults().stringForKey(VTConfID)
            textField.text = text
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    /*
     *  MARK: Present conference viewController
     */
    
    private func presentConferenceVC(confID: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let conferenceVC = storyboard.instantiateViewControllerWithIdentifier("Conference") as! Conference
        conferenceVC.conferenceID = confID
        self.presentViewController(conferenceVC, animated: true, completion: nil)
    }
}
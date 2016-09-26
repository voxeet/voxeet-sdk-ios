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
    
    @IBAction func createConference(_ sender: AnyObject) {
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
    
    @IBAction func joinConference(_ sender: AnyObject) {
        // Alert view.
        let alertController = UIAlertController(title: "Conference ID", message: "Please input the conference ID:", preferredStyle: .alert)
        
        // Alert actions.
        let confirmAction = UIAlertAction(title: "Join", style: .default) { (_) in
            if let textField = alertController.textFields?[0],
                let confID = textField.text {
                
                // Start the conference viewController.
                self.presentConferenceVC(confID)
                
                // Save the current conference ID.
                UserDefaults.standard.set(confID, forKey: VTConfID)
                UserDefaults.standard.synchronize()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        // Alert textField.
        alertController.addTextField { (textField) in
            textField.placeholder = "Conference ID"
            textField.clearButtonMode = .whileEditing
            
            // Setting the textfield's text with the previous text saved (NSUserDefaults).
            let text = UserDefaults.standard.string(forKey: VTConfID)
            textField.text = text
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    /*
     *  MARK: Present conference viewController
     */
    
    fileprivate func presentConferenceVC(_ confID: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let conferenceVC = storyboard.instantiateViewController(withIdentifier: "Conference") as! Conference
        conferenceVC.conferenceID = confID
        self.present(conferenceVC, animated: true, completion: nil)
    }
}

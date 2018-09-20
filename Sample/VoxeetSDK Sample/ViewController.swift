//
//  ViewController.swift
//  VoxeetSDK Sample
//
//  Created by Coco on 22/04/16.
//  Copyright © 2016 Corentin Larroque. All rights reserved.
//

import UIKit
import VoxeetSDK

class ViewController: UIViewController {
    
    // Constant NSUserDefaults to save previous conference name.
    let conferenceName = "VTConferenceName"
    
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
        VoxeetSDK.shared.conference.create(success: { (json) in
            guard let conferenceID = json?["conferenceId"] as? String, let conferenceAlias = json?["conferenceAlias"] as? String else {
                // Debug.
                print("[ERROR] \(String(describing: self)).\(#function).\(#line)")
                return
            }
            
            // Debug.
            print("[DEBUG] \(String(describing: self)).\(#function).\(#line) - Conference ID: \(conferenceID), conference alias: \(conferenceAlias)")
            
            // Start the conference viewController.
            self.presentConferenceVC(conferenceName: conferenceAlias)
        }, fail: { (error) in
            // Debug.
            print("[ERROR] \(String(describing: self)).\(#function).\(#line) - Error: \(error)")
        })
    }
    
    @IBAction func joinConference(_ sender: AnyObject) {
        // Alert view.
        let alertController = UIAlertController(title: "Conference ID", message: "Please input the conference ID:", preferredStyle: .alert)
        
        // Alert actions.
        let confirmAction = UIAlertAction(title: "Join", style: .default) { (_) in
            if let textField = alertController.textFields?[0],
                let conferenceName = textField.text {
                
                // Start the conference viewController.
                self.presentConferenceVC(conferenceName: conferenceName)
                
                // Save the current conference name.
                UserDefaults.standard.set(conferenceName, forKey: self.conferenceName)
                UserDefaults.standard.synchronize()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        // Alert textField.
        alertController.addTextField { (textField) in
            textField.placeholder = "Conference ID"
            textField.clearButtonMode = .whileEditing
            
            // Setting the textfield's text with the previous text saved (NSUserDefaults).
            let text = UserDefaults.standard.string(forKey: self.conferenceName)
            textField.text = text
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    /*
     *  MARK: Present conference viewController
     */
    
    private func presentConferenceVC(conferenceName: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let conferenceVC = storyboard.instantiateViewController(withIdentifier: "Conference") as! ConferenceViewController
        conferenceVC.conferenceID = conferenceName
        self.present(conferenceVC, animated: true, completion: nil)
    }
}

//
//  AppDelegate.swift
//  VoxeetSDK Sample
//
//  Created by Coco on 22/04/16.
//  Copyright © 2016 Corentin Larroque. All rights reserved.
//

import UIKit
import VoxeetSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, VTSessionDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Initialization of the Voxeet SDK.
        VoxeetSDK.shared.initialize(consumerKey: "YOUR_CONSUMER_KEY", consumerSecret: "YOUR_CONSUMER_SECRET")
        
        // Start conference on the main speaker by default.
        VoxeetSDK.shared.conference.defaultBuiltInSpeaker = true
        
        // Session delegate.
        VoxeetSDK.shared.session.delegate = self
        
        return true
    }
    
    /*
     *  MARK: VTSessionDelegate example
     */
    
    func sessionUpdated(state: VTSessionState) {
        // Debug.
        print("[DEBUG] \(String(describing: self)).\(#function).\(#line) - State: \(state.rawValue)")
    }
}

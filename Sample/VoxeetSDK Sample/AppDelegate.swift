//
//  AppDelegate.swift
//  VoxeetSDK Sample
//
//  Created by Coco on 22/04/16.
//  Copyright © 2016 Corentin Larroque. All rights reserved.
//

import UIKit
import CoreData
import VoxeetSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, VTSessionStateDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Start conference on the main speaker by default.
        VoxeetSDK.shared.defaultBuiltInSpeaker = true
        // Disable CallKit.
        VoxeetSDK.shared.enableCallKit = false
        
        // Initialization of the Voxeet SDK.
        VoxeetSDK.shared.initializeSDK(consumerKey: "consumerKey", consumerSecret: "consumerSecret")
        
        // Session delegate.
        VoxeetSDK.shared.sessionStateDelegate = self
        
        return true
    }
    
    /*
     *  MARK: VTSessionState Delegate
     */
    
    func sessionStateChanged(state: VTSessionState) {
        // Debug.
        print("[DEBUG] \(String(describing: self)).\(#function).\(#line) - State: \(state)")
    }
}

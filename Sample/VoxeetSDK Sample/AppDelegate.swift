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
class AppDelegate: UIResponder, UIApplicationDelegate, VTSessionDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Initialization of the Voxeet SDK.
        VoxeetSDK.shared.initialize(consumerKey: "consumerKey", consumerSecret: "consumerSecret")
        
        // Start conference on the main speaker by default.
        VoxeetSDK.shared.defaultBuiltInSpeaker = true
        
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

//
//  VTUser+Extension.swift
//  VoxeetSDK Sample
//
//  Created by Coco on 31/10/2017.
//  Copyright © 2017 Corentin Larroque. All rights reserved.
//

import VoxeetSDK

extension VTUser {
    convenience init(id: String, name: String? = nil, photoURL: String? = nil) {
        self.init()
        
        var info = [String: Any]()
        info["externalId"] = id
        info["externalName"] = name
        info["externalPhotoUrl"] = photoURL
        
        self.info["metadata"] = info
    }
    
    func externalID() -> String? {
        return (info["metadata"] as? [String: Any])?["externalId"] as? String
    }
    
    func externalName() -> String? {
        return (info["metadata"] as? [String: Any])?["externalName"] as? String
    }
    
    func externalPhotoURL() -> String? {
        return (info["metadata"] as? [String: Any])?["externalPhotoUrl"] as? String
    }
}

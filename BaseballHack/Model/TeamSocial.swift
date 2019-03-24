//
//  Team.swift
//  BaseballHack
//
//  Created by Zack Aroui on 3/10/19.
//  Copyright © 2019 GameChanger. All rights reserved.
//

import Foundation

class TeamSocial {
    
    var date: Date
    var assetURLs: TeamSocialAssetUrls
    var name: String
    var label: String
    var title: String
    var type: String
    var url: String
    var remoteID: Int
    
    init(jsonData: [String: Any]) {
        self.date = jsonData["date"] as? Date ?? Date()
        self.assetURLs = TeamSocialAssetUrls(jsonData: jsonData["assetURLs"] as! [String : Any]) 
        self.name = jsonData["name"] as? String ?? ""
        self.label = jsonData["label"] as? String ?? ""
        self.title = jsonData["title"] as? String ?? ""
        self.type = jsonData["type"] as? String ?? ""
        self.url = jsonData["url"] as? String ?? ""
        self.remoteID = jsonData["remoteID"] as? Int ?? 0
    }
    
}


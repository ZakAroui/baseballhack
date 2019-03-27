//
//  Team.swift
//  BaseballHack
//
//  Created by Zack Aroui on 3/10/19.
//  Copyright © 2019 GameChanger. All rights reserved.
//

import Foundation

class TeamAssest {
    
    var date: Date
    var duration: Int
    var gameID: Int
    var assetID: Int
    var pointsLevel: String
    var description: String
    var type: String
    var title: String
    var sport: String
    var url: String
    
    init(jsonData: [String: Any]) {
        self.date = jsonData["date"] as? Date ?? Date()
        self.duration = jsonData["duration"] as? Int ?? 0
        self.gameID = jsonData["gameID"] as? Int ?? 0
        self.assetID = jsonData["assetID"] as? Int ?? 0
        self.pointsLevel = jsonData["pointsLevel"] as? String ?? ""
        self.description = jsonData["description"] as? String ?? ""
        self.type = jsonData["type"] as? String ?? ""
        self.title = jsonData["title"] as? String ?? ""
        self.sport = jsonData["sport"] as? String ?? ""
        self.url = jsonData["url"] as? String ?? ""
    }
    
}


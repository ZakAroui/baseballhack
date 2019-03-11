//
//  Team.swift
//  BaseballHack
//
//  Created by Zack Aroui on 3/10/19.
//  Copyright © 2019 GameChanger. All rights reserved.
//

import Foundation

class Team {
    
    var wins: Int
    var color: String
    var form: String
    var leagueCodes: [String]
    var city: String
    var initials: String
    var teamID: Int
    var name: String
    var nickname: String
    var leagueCode: String
    var losses: Int
    var sport: String
    
    init(jsonData: [String: Any]) {
        self.wins = jsonData["wins"] as? Int ?? 0
        self.color = jsonData["color"] as? String ?? ""
        self.form = jsonData["form"] as? String ?? ""
        self.leagueCodes = jsonData["leagueCodes"] as? [String] ?? []
        self.city = jsonData["city"] as? String ?? ""
        self.initials = jsonData["initials"] as? String ?? ""
        self.teamID = jsonData["teamID"] as? Int ?? 0
        self.name = jsonData["name"] as? String ?? ""
        self.nickname = jsonData["nickname"] as? String ?? ""
        self.leagueCode = jsonData["leagueCode"] as? String ?? ""
        self.losses = jsonData["losses"] as? Int ?? 0
        self.sport = jsonData["sport"] as? String ?? ""
        
    }
    
}

extension Team {
    func fullname() -> String {
        return name + " (" + initials + ")"
    }
}

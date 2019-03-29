//
//  Team.swift
//  BaseballHack
//
//  Created by Zack Aroui on 3/10/19.
//  Copyright © 2019 GameChanger. All rights reserved.
//

import Foundation
import os.log

class Team: NSObject, NSCoding {
    
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
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("teams")
    
    struct PropertyKey {
        static let name = "name"
        static let color = "color"
        static let teamID = "teamID"
    }
    
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
    
    init(name: String, color: String, teamID: Int) {
        self.wins =  0
        self.color = color
        self.form = ""
        self.leagueCodes =  []
        self.city =  ""
        self.initials =  ""
        self.teamID = teamID
        self.name = name
        self.nickname = ""
        self.leagueCode =  ""
        self.losses =  0
        self.sport =  ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(color, forKey: PropertyKey.color)
        aCoder.encode(teamID, forKey: PropertyKey.teamID)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let color = aDecoder.decodeObject(forKey: PropertyKey.color)
        let teamID = aDecoder.decodeInteger(forKey: PropertyKey.teamID)
        
        self.init(name: name, color: color as! String, teamID: teamID)
    }
    
}

extension Team {
    func fullname() -> String {
        return name + " (" + initials + ")"
    }
}

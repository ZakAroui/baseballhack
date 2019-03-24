//
//  Team.swift
//  BaseballHack
//
//  Created by Zack Aroui on 3/10/19.
//  Copyright © 2019 GameChanger. All rights reserved.
//

import Foundation

class TeamSocialAssetUrls {
    
    var profileBackgroundImage: String
    var profileImage: String
    
    init(){
        self.profileBackgroundImage = ""
        self.profileImage = ""
    }
    
    init(jsonData: [String: Any]) {
        self.profileBackgroundImage = jsonData["profileBackgroundImage"] as? String ?? ""
        self.profileImage = jsonData["profileImage"] as? String ?? ""
    }
    
}


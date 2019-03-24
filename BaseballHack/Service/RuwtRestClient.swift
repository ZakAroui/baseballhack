//
//  RuwtRestClient.swift
//  BaseballHack
//
//  Created by Zack Aroui on 3/10/19.
//  Copyright © 2019 GameChanger. All rights reserved.
//

import Foundation
import Alamofire

class RuwtRestClient {
    
    let mlbTeams: String = "https://baseballhackday.api.areyouwatchingthis.com/api/teams.json?sport=mlb&apiKey=5fd60caae9c0ccda4925a523be8d0533"
    let teamSocial: String = "https://baseballhackday.api.areyouwatchingthis.com/api/social.json?apiKey=5fd60caae9c0ccda4925a523be8d0533&teamID="
    
    func getTeams(completion: @escaping ([Team]?) -> Void){
        
        AF.request(mlbTeams, method: .get)
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("couldn't get /teams.json")
                    return
                }

                guard let value = response.result.value as? [String: Any],
                    let results = value["results"] as? [[String: Any]] else {
                        print("Malformed data received from /teams.json service")
                        return
                }
                
                let teams = results.compactMap { teamDict in
                    return Team(jsonData: teamDict) }
               
                completion(teams)
        }
        
    }
    
    func getTeamSocial(completion: @escaping ([TeamSocial]?) -> Void, teamId: String){
        let thisTeamSocial = teamSocial + "7073"
        
        AF.request(thisTeamSocial, method: .get)
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("couldn't get /social.json")
                    return
                }
                
                guard let value = response.result.value as? [String: Any],
                    let results = value["results"] as? [[String: Any]] else {
                        print("Malformed data received from /social.json service")
                        return
                }
                
                let teamSocials = results.compactMap { socialDict in
                    return TeamSocial(jsonData: socialDict) }
                
                completion(teamSocials)
        }
    }
    
}

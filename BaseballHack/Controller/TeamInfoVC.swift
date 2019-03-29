//
//  TeamInfoVC.swift
//  BaseballHack
//
//  Created by Zak Aroui on 3/9/19.
//  Copyright © 2019 GameChanger. All rights reserved.
//

import UIKit

class TeamInfoVC: UIViewController {
    
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var teamColor: UIView!
    @IBOutlet weak var winsValue: UILabel!
    @IBOutlet weak var lossesValue: UILabel!
    @IBOutlet weak var league: UILabel!
    
    var team: Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tbvc = self.tabBarController  as! TeamInfoTBC
        team = tbvc.team
        
        teamName.text = team?.fullname()
        city.text = team?.city
        teamColor.backgroundColor = TeamsInfoTableVC.hexStringToUIColor(hex: team!.color, alpha: 0.5)
        winsValue.text = String((team?.wins)!)
        lossesValue.text = String((team?.losses)!)
        league.text = team?.leagueCode
        
    }
    
    

}

//
//  TeamInfoVC.swift
//  BaseballHack
//
//  Created by Zak Aroui on 3/9/19.
//  Copyright © 2019 GameChanger. All rights reserved.
//

import UIKit

class TeamInfoVC: UIViewController {
    
    var team: Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tbvc = self.tabBarController  as! TeamInfoTBC
        team = tbvc.team
    }
    
    

}

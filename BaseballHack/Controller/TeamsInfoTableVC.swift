//
//  TeamsInfoTableVC.swift
//  BaseballHack
//
//  Created by Zak Aroui on 3/9/19.
//  Copyright © 2019 GameChanger. All rights reserved.
//

import UIKit

class TeamsInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var winsValLabel: UILabel!
    @IBOutlet weak var losesValLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var infoStackView: UIStackView!
}

class TeamsInfoTableVC: UITableViewController {
    var teamList: [Team] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ruwt = RuwtRestClient()
        ruwt.getTeams(completion: {tms in
            self.teamList = tms!
            self.tableView.reloadData()
            print(tms![5].name)
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamInfoCell", for: indexPath) as! TeamsInfoTableViewCell
        
        let team = teamList[indexPath.row]
        cell.backgroundColor = hexStringToUIColor(hex: team.color, alpha: 0.5)
        cell.titleLabel?.text = team.name
        cell.cityLabel?.text = team.city + " (" + team.initials + ")"
        cell.winsValLabel?.text = String(team.wins)
        cell.losesValLabel?.text = String(team.losses)
        cell.logoImageView?.image = UIImage(named: String(team.teamID))
        
        return cell
    }
    
    func hexStringToUIColor (hex:String, alpha: Float) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.white
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
}

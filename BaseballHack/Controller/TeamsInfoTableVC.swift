//
//  TeamsInfoTableVC.swift
//  BaseballHack
//
//  Created by Zak Aroui on 3/9/19.
//  Copyright © 2019 GameChanger. All rights reserved.
//

import UIKit
import os.log

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
        
        if let lst = loadTeams() {
            teamList = lst
        }
        
        let ruwt = RuwtRestClient()
        ruwt.getTeams(completion: {tms in
            self.teamList = tms!
            self.saveTeams()
            self.tableView.reloadData()
        })
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamList.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case "ShowTeamDetail":
            let tabBarC : TeamInfoTBC = segue.destination as! TeamInfoTBC;
            
            guard let selectedTeamCell = sender as? TeamsInfoTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedTeamCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedTeam = teamList[indexPath.row]
            tabBarC.team = selectedTeam
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamInfoCell", for: indexPath) as! TeamsInfoTableViewCell
        
        let team = teamList[indexPath.row]
        cell.backgroundColor = TeamsInfoTableVC.hexStringToUIColor(hex: team.color, alpha: 0.5)
        cell.titleLabel?.text = team.name
        cell.cityLabel?.text = team.city + " (" + team.initials + ")"
        cell.winsValLabel?.text = String(team.wins)
        cell.losesValLabel?.text = String(team.losses)
        cell.logoImageView?.image = UIImage(named: String(team.teamID))
        
        return cell
    }
    
    private func saveTeams() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(teamList, toFile: Team.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Teams successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save teams...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadTeams() -> [Team]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Team.ArchiveURL.path) as? [Team]
    }
    
    static func hexStringToUIColor (hex:String, alpha: Float) -> UIColor {
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

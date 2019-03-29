//
//  TeamsInfoTableVC.swift
//  BaseballHack
//
//  Created by Zak Aroui on 3/9/19.
//  Copyright © 2019 GameChanger. All rights reserved.
//

import UIKit
import SDWebImage

class TeamAssetTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var pLevel: UILabel!
    @IBOutlet weak var desc: UILabel!
}

class TeamAssetsTableVC: UITableViewController {
    var teamAssetList: [TeamAssest] = []
    var team: Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tbvc = self.tabBarController  as! TeamInfoTBC
        team = tbvc.team
        
        let ruwt = RuwtRestClient()
        ruwt.getTeamAssets(completion: {tms in
            self.teamAssetList = tms!
            self.tableView.reloadData()
        }, teamId: String(team!.teamID))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamAssetList.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case "ShowAssetWeb":
            print("inside ShowAssetWebSegue")
            let webViewVC : WebViewVC = segue.destination as! WebViewVC;
            
            guard let selectedAssetCell = sender as? TeamAssetTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedAssetCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedAsset = teamAssetList[indexPath.row]
            webViewVC.sourceVc = WebViewSource.asset
            webViewVC.teamAsset = selectedAsset
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamAssetCell", for: indexPath) as! TeamAssetTableViewCell
        
        let asset = teamAssetList[indexPath.row]
        cell.title?.text = asset.title
        cell.pLevel?.text = " "+asset.pointsLevel
        cell.desc?.text = asset.description
        
        return cell
    }
}


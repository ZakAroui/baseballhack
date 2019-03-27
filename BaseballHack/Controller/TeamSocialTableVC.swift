//
//  TeamsInfoTableVC.swift
//  BaseballHack
//
//  Created by Zak Aroui on 3/9/19.
//  Copyright © 2019 GameChanger. All rights reserved.
//

import UIKit
import SDWebImage

class TeamSocialTableViewCell: UITableViewCell {
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var tweetTitle: UILabel!
}

class TeamSocialTableVC: UITableViewController {
    var teamSocialList: [TeamSocial] = []
    var team: Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tbvc = self.tabBarController  as! TeamInfoTBC
        team = tbvc.team
        
        let ruwt = RuwtRestClient()
        ruwt.getTeamSocial(completion: {tms in
            self.teamSocialList = tms!
            self.tableView.reloadData()
            print(tms![5].name)
        }, teamId: String(team!.teamID))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamSocialList.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case "ShowSocialWeb":
            print("inside ShowSocialWebSegue")
            let webViewVC : WebViewVC = segue.destination as! WebViewVC;
            
            guard let selectedSocialCell = sender as? TeamSocialTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedSocialCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedTeam = teamSocialList[indexPath.row]
            webViewVC.teamSocial = selectedTeam
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamSocialCell", for: indexPath) as! TeamSocialTableViewCell
        
        let socialTweet = teamSocialList[indexPath.row]
        cell.profileName?.text = socialTweet.name
        cell.tweetLabel?.text = " "+socialTweet.label
        cell.tweetTitle?.text = socialTweet.title
        
        cell.profilePicture?.sd_setImage(with: URL(string: socialTweet.assetURLs.profileImage), placeholderImage: UIImage(named: "7073"))

        return cell
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

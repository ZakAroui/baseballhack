//
//  NewsTableViewController.swift
//  BaseballHack
//
//  Created by Zack Aroui on 3/9/19.
//  Copyright © 2019 GameChanger. All rights reserved.
//

import UIKit

struct Headline {
    
    var id : Int
    var title : String
    var text : String
    var image : String
    
}

class HeadlineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headlineTitleLabel: UILabel!
    @IBOutlet weak var headlineTextLabel: UILabel!
    @IBOutlet weak var headlineImageView: UIImageView!
    
}

class NewsTableViewController: UITableViewController {
    
    var headlines = [
        Headline(id: 1, title: "Yankees buy back YES network from Disney in $3.5B deal", text: "The New York Yankees have repurchased the Yankees Entertainment and Sports (YES) network from Disney for $3.5 billion in a deal that is expected to close Friday, FOX Business has learned.", image: "news1"),
        Headline(id: 2, title: "The Yankees’ loss in the broadcast booth is the Mets’ gain in the front office", text: "The Yankees' loss in the broadcast booth is the Mets' gain in the front office ... The New York Post broke the news in January that Leiter was leaving YES", image: "news2"),
        Headline(id: 3, title: "Aaron Hicks, Yankees agree to $70M, 7-year deal", text: "Outfielder Aaron Hicks and the New York Yankees have agreed to a $70 ... Business ... This is the organization I want to stay with, Hicks said during a news", image: "news3"),
        Headline(id: 4, title: "Sports betting at Yankee Stadium? It could happen under New York legislation", text: "Outfielder Aaron Hicks and the New York Yankees have agreed to a $70 ... Business ... This is the organization I want to stay with, Hicks said during a news", image: "news4"),
        Headline(id: 5, title: "The Yankees are loading up in their bullpen, and it's changing how they spend elsewhere", text: "The Yankees committed about $50 million to their bullpen in 2018, and that number could go up this year", image: "news5"),
        
        ]
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlines.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! HeadlineTableViewCell
        
        let headline = headlines[indexPath.row]
        cell.headlineTitleLabel?.text = headline.title
        cell.headlineTextLabel?.text = headline.text
        cell.headlineImageView?.image = UIImage(named: headline.image)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

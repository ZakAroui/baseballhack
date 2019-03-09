//
//  ViewController.swift
//  BaseballHack
//
//  Created by Zack Esm on 3/9/19.
//  Copyright © 2019 GameChanger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private var teams = [(name: String, logo: UIImage?, eval: Int)]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TeamCell.self, forCellReuseIdentifier: "TeamCell")
        
        teams = [
            (name: "New York Yankees", logo: #imageLiteral(resourceName: "yankeesLogo"), eval: 400),
            (name: "Los Angeles Dodgers", logo: #imageLiteral(resourceName: "dodgersLogo"), eval: 300),
            (name: "Chicago Cubs", logo: #imageLiteral(resourceName: "cubsLogo"), eval: 290),
            (name: "San Francisco Giants", logo: #imageLiteral(resourceName: "giantsLogo"), eval: 285),
            (name: "Boston Red Sox", logo: #imageLiteral(resourceName: "soxLogo"), eval: 280),
        ]
        
        setupViews()
    }
    
    fileprivate func setupViews() {
        let margins = view.layoutMarginsGuide
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: margins.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
            ])
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell", for: indexPath) as? TeamCell {
            let team = teams[indexPath.row]
            cell.configureTeamCell(team: team)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = GraphVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


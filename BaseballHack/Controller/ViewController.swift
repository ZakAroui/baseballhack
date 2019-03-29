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
        
        title = "Sportfolio"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TeamCell.self, forCellReuseIdentifier: "TeamCell")
        
        teams = [
            (name: "New York Yankees", logo: #imageLiteral(resourceName: "7073"), eval: 400),
            (name: "Los Angeles Dodgers", logo: #imageLiteral(resourceName: "13382"), eval: 300),
            (name: "Chicago Cubs", logo: #imageLiteral(resourceName: "13377"), eval: 290),
            (name: "San Francisco Giants", logo: #imageLiteral(resourceName: "13388"), eval: 285),
            (name: "Boston Red Sox", logo: #imageLiteral(resourceName: "7066"), eval: 280),
        ]
        
        addTeamsInfoButton()
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
    
    fileprivate func addTeamsInfoButton() {
        let teamsInfoButton = UIButton(type: .custom)
        teamsInfoButton.setTitle("Teams Info", for: .normal)
        teamsInfoButton.setTitleColor(.blue, for: .normal)
        teamsInfoButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        teamsInfoButton.addTarget(self, action: #selector(showTeamsInfo), for: .touchUpInside)
        let infoItem = UIBarButtonItem(customView: teamsInfoButton)
        
        navigationItem.rightBarButtonItem = infoItem
    }
    
    @objc func showTeamsInfo() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "teamsInfoBoard") as UIViewController
        navigationController?.pushViewController(vc, animated: true)
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


//
//  TeamCell.swift
//  BaseballHack
//
//  Created by Zack Esm on 3/9/19.
//  Copyright © 2019 GameChanger. All rights reserved.
//

import UIKit

class TeamCell: UITableViewCell {
    
    private let logo: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .clear
        return iv
    }()
    
    private let teamLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.textColor = .black
        return lbl
    }()
    
    private let evalLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.textColor = .gray
        lbl.text = "$400K"
        return lbl
    }()
    
    func configureTeamCell(team: (name: String, logo: UIImage?, eval: Int)) {
        teamLabel.text = team.name
        logo.image = team.logo
        evalLabel.text = "$\(team.eval).00"
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        let margins = contentView.layoutMarginsGuide
        
        contentView.addSubview(logo)
        NSLayoutConstraint.activate([
            logo.centerYAnchor.constraint(equalTo: margins.centerYAnchor),
            logo.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            logo.widthAnchor.constraint(equalToConstant: 30),
            logo.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        contentView.addSubview(teamLabel)
        NSLayoutConstraint.activate([
            teamLabel.topAnchor.constraint(equalTo: margins.topAnchor),
            teamLabel.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 20),
            teamLabel.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.6),
            teamLabel.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
            ])
        
        contentView.addSubview(evalLabel)
        NSLayoutConstraint.activate([
            evalLabel.topAnchor.constraint(equalTo: margins.topAnchor),
            evalLabel.leadingAnchor.constraint(equalTo: teamLabel.trailingAnchor, constant: 10),
            evalLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            evalLabel.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
            ])
    }
    
    

}

//
//  MainHeaderView.swift
//  Car Service App
//
//  Created by Murat Baykor on 6.08.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class MainHeaderView: UIView {

    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let settingsButton = UIButton(type: .custom)
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureNameLabel()
        configureSettingsButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        backgroundColor = Colors.backgroundBlue2

    }
    
    private func configureNameLabel() {
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
        ])
    }
    
    
    private func configureSettingsButton() {
        addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .large)
        
        settingsButton.setImage(UIImage(systemName: "gear", withConfiguration: largeConfig), for: .normal)
        
        settingsButton.tintColor = .white
        
        NSLayoutConstraint.activate([
            settingsButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            
        ])
    }
  
    func set(user: User, verifyStatus: Bool?) {
        nameLabel.text = user.name
        if verifyStatus == true {
            nameLabel.textColor = .white
        } else {
            nameLabel.textColor = .red
        }
        
    }

}

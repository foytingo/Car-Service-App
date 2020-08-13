//
//  MainHeaderView.swift
//  Car Service App
//
//  Created by Murat Baykor on 6.08.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

protocol MainHeaderViewDelegate: class {
    func didTapSettingsButton()
}

class MainHeaderView: UIView {
    
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    let stackView = UIStackView()
    let settingsButton = UIButton(type: .custom)
    
    weak var mainHeaderViewDelegate: MainHeaderViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureTitleLabel()
        configureEmailLabel()
        configureStackView()
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
    
    
    private func configureTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    
    private func configureEmailLabel() {
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.textColor = .white
        detailLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    }
    
    
    private func configureStackView() {
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis          = .vertical
        stackView.distribution  = .equalSpacing
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(detailLabel)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
    }
    
    
    private func configureSettingsButton() {
        addSubview(settingsButton)
        
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .large)
        settingsButton.setImage(UIImage(systemName: "gear", withConfiguration: largeConfig), for: .normal)
        settingsButton.tintColor = .white
        settingsButton.addTarget(self, action: #selector(handleSettingsButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            settingsButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingsButton.centerXAnchor.constraint(equalTo: trailingAnchor, constant: -55)
        ])
    }
    
    
    @objc func handleSettingsButton() {
        mainHeaderViewDelegate.didTapSettingsButton()
    }
    
    
    func set(title: String, detail: String) {
        titleLabel.text = title
        detailLabel.text = detail
    }
    
    
}

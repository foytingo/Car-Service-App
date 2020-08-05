//
//  CSASelectPropertiesView.swift
//  Car Service App
//
//  Created by Murat Baykor on 5.08.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class CSASelectPropertiesView: UIView {

    let label = UILabel()
    let detailLabel = UILabel()
    let disclosureIndicator = UIImageView()
    let lineView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        configureLabel()
        configureDetailLabel()
        configureDisclosureIndicator()
        configureLineView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(labelText: String, tag: Int) {
        self.init(frame: .zero)
        self.label.text = labelText
        self.tag = tag
    }
    
    
    
    private func configureLabel() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureDetailLabel() {
        addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.textColor = Colors.softBlue
        detailLabel.text = "Select"
        NSLayoutConstraint.activate([
            detailLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor ,constant: -30),
            detailLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureDisclosureIndicator() {
        addSubview(disclosureIndicator)
        disclosureIndicator.translatesAutoresizingMaskIntoConstraints = false
        disclosureIndicator.image = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
        disclosureIndicator.tintColor = .white
        NSLayoutConstraint.activate([
            disclosureIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            disclosureIndicator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
        ])
    }
    
    private func configureLineView() {
        addSubview(lineView)
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
}

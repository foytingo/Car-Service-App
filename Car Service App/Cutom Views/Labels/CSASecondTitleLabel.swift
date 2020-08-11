//
//  CSASecondTitleLabel.swift
//  Car Service App
//
//  Created by Murat Baykor on 10.08.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class CSASecondTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        textColor = Colors.softBlue
        textAlignment = .left
        
        font = UIFont.systemFont(ofSize: 18, weight: .medium )
    }

}

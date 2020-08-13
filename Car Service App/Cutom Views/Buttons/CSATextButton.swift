//
//  CSATextButton.swift
//  Car Service App
//
//  Created by Murat Baykor on 27.07.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class CSATextButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(title: String, color: UIColor) {
        self.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
    }
    
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        titleLabel?.font    = UIFont.preferredFont(forTextStyle: .subheadline)
        setTitleColor(Colors.softBlue, for: .normal)
    }
    

}

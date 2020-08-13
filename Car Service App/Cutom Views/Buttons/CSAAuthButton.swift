//
//  CSAAuthButton.swift
//  Car Service App
//
//  Created by Murat Baykor on 27.07.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class CSAAuthButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(title: String) {
        self.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
    }
    
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Colors.softBlue
        layer.cornerRadius  = 5
        titleLabel?.font    = UIFont.preferredFont(forTextStyle: .headline)
        setTitleColor(.white, for: .normal)
    }
    
    
}

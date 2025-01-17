//
//  CSATextField.swift
//  Car Service App
//
//  Created by Murat Baykor on 27.07.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class CSATextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.systemFont(ofSize: 14, weight: .medium)
        textColor = .white
        tintColor = .white
        autocapitalizationType = .none
        isSecureTextEntry = false
        autocorrectionType = .no
        clearButtonMode = .whileEditing
    }
    
    
}



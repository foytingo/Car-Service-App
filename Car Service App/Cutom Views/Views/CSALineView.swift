//
//  CSALineView.swift
//  Car Service App
//
//  Created by Murat Baykor on 12.08.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class CSALineView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
    }
    
    
    func setColor(with color: UIColor) {
        backgroundColor = color
    }
    
    
}

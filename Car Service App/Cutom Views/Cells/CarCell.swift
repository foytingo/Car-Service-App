//
//  CarCell.swift
//  Car Service App
//
//  Created by Murat Baykor on 6.08.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class CarCell: UITableViewCell {

    let backView = UIView()
    let carID = UILabel()
    let carKm = UILabel()
    let actionButton = UIButton()
    
    static let reuseID = "CarCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureBackView()
        configureCarId()
        backgroundColor = .clear
        
   }
   
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
    
    private func configureBackView() {
        addSubview(backView)
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.layer.cornerRadius = 10
        backView.backgroundColor = Colors.backgroundBlue2
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    private func configureCarId() {
        backView.addSubview(carID)
        carID.translatesAutoresizingMaskIntoConstraints = false
        carID.textColor = .white
        
       NSLayoutConstraint.activate([
        carID.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
        carID.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 20),
            
        ])
    }
    
    func set(car: Car) {
        carID.text = car.plateNumber
    }

}

//
//  CarCell.swift
//  Car Service App
//
//  Created by Murat Baykor on 6.08.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

protocol CarCellDelegate: class {
    func didTapActionButton(_ cell: CarCell)
}

class CarCell: UITableViewCell {
    
    let backView = UIView()
    let carDetail = UILabel()
    let carID = UILabel()
    let carKm = UILabel()
    let stackView = UIStackView()
    let actionButton = UIButton()
    
    var car: Car?
    
    static let reuseID = "CarCell"
    
    weak var carCellDelegate: CarCellDelegate!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        configureBackView()
        configureCarId()
        configureCarKm()
        configureCarDetail()
        configureStackView()
        configureActionButton()
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
        carID.translatesAutoresizingMaskIntoConstraints = false
        carID.textColor = .white
        carID.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    
    private func configureCarKm() {
        carKm.translatesAutoresizingMaskIntoConstraints = false
        carKm.textColor = .white
        carKm.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    }
    
    
    private func configureCarDetail() {
        carDetail.translatesAutoresizingMaskIntoConstraints = false
        carDetail.textColor = .white
        carKm.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    }
    
    
    private func configureStackView() {
        backView.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
       
        stackView.addArrangedSubview(carID)
        stackView.addArrangedSubview(carDetail)
        stackView.addArrangedSubview(carKm)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 20),
        ])
    }
    
    
    func configureActionButton() {
        backView.addSubview(actionButton)
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.backgroundColor = Colors.softBlue
        actionButton.setTitle("SET", for: .normal)
        actionButton.layer.cornerRadius = 5
        actionButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        actionButton.titleLabel?.textAlignment = .center
        actionButton.titleLabel?.lineBreakMode = .byWordWrapping
        actionButton.titleLabel?.numberOfLines = 2
        actionButton.setTitleColor(.white, for: .normal)
        
        actionButton.addTarget(self, action: #selector(handleActionButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10),
            actionButton.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -20),
            actionButton.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -10),
            actionButton.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    
    @objc func handleActionButton() {
        carCellDelegate.didTapActionButton(self)
    }
    
 
    func set(car: Car) {
        self.car = car
        carID.text = car.plateNumber.uppercased()
        carDetail.text = "\(car.brand) - \(car.year) - \(car.model)"
        carKm.text = "Current Kilometer: \(car.currentKm)"
    }
    
}

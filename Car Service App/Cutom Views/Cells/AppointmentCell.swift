//
//  AppointmentCell.swift
//  Car Service App
//
//  Created by Murat Baykor on 11.08.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

protocol AppointmentCellDelegate: class {
    func didTapActionButton(_ cell: AppointmentCell)
}

class AppointmentCell: UITableViewCell {
    
    let backView = UIView()
    let carDetail = UILabel()
    let phoneNumber = UILabel()
    let date = UILabel()
    let stackView = UIStackView()
    let actionButton = UIButton()
    
    var appointment: Appointment?
    static let reuseID = "AppointmentCell"
    
    weak var appointmentCellDelegate: AppointmentCellDelegate!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureBackView()
        configureCarDetail()
        configureDate()
        configurePhoneNumber()
        configureStackView()
        configureActionButton()
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
    
    private func configurePhoneNumber() {
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        phoneNumber.textColor = .white
        phoneNumber.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    }
    
    private func configureCarDetail() {
        carDetail.translatesAutoresizingMaskIntoConstraints = false
        carDetail.textColor = .white
        carDetail.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    }
    
    private func configureDate() {
        date.translatesAutoresizingMaskIntoConstraints = false
        date.textColor = .white
        date.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    private func configureStackView() {
        backView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        
        stackView.addArrangedSubview(date)
        stackView.addArrangedSubview(phoneNumber)
        stackView.addArrangedSubview(carDetail)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 20),
            
        ])
    }
    
    func configureActionButton() {
        backView.addSubview(actionButton)
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.backgroundColor = .systemRed
        actionButton.setTitle("Delete", for: .normal)
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
        appointmentCellDelegate.didTapActionButton(self)
    }
    
    func set(appointment: Appointment) {
        self.appointment = appointment
        date.text = appointment.date
        carDetail.text = "Kilometer: 9999"
        phoneNumber.text = appointment.phoneNumber
    }
}

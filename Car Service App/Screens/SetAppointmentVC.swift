//
//  SetAppointmentVC.swift
//  Car Service App
//
//  Created by Murat Baykor on 10.08.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class SetAppointmentVC: CSALoadingVC {
    
    let titleLabel = CSATitleLabel()
    let carLabel = CSASecondTitleLabel()
    let phoneNumberTextFieldView = CSATextFieldView()
    let dateTextFieldView = CSATextFieldView()
    let doneButton = CSAAuthButton(title: "Done")
    let cancelButton = CSATextButton(title: "Cancel", color: Colors.softBlue)
    
    var car: Car?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureTitleLabel()
        configureCarLabel()
        configurenPhoneTextFieldView()
        configureDateTextFieldView()
        configureDoneButton()
        configureCancelButton()
    }
    
    
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.text = "Set Appointment"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 125),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50)
        ])
    }
    
    
    func configureCarLabel() {
        view.addSubview(carLabel)
        
        guard let car = car else {return}
        carLabel.text = "\(car.plateNumber) - \(car.model) - \(car.currentKm) km"
        
        NSLayoutConstraint.activate([
            carLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            carLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50)
        ])
    }
    
    
    func configurenPhoneTextFieldView() {
        view.addSubview(phoneNumberTextFieldView)
        
        addTapGesture(view: phoneNumberTextFieldView)
        phoneNumberTextFieldView.set(textFieldType: .phone)
        phoneNumberTextFieldView.textField.delegate = self
        
        NSLayoutConstraint.activate([
            phoneNumberTextFieldView.topAnchor.constraint(equalTo: carLabel.bottomAnchor, constant: 20),
            phoneNumberTextFieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneNumberTextFieldView.heightAnchor.constraint(equalToConstant: 75),
            phoneNumberTextFieldView.widthAnchor.constraint(equalToConstant: 325)
        ])
    }
    
    
    func configureDateTextFieldView() {
        view.addSubview(dateTextFieldView)
        addTapGesture(view: dateTextFieldView)
        dateTextFieldView.set(textFieldType: .appointment)
        dateTextFieldView.textField.delegate = self
        
        NSLayoutConstraint.activate([
            dateTextFieldView.topAnchor.constraint(equalTo: phoneNumberTextFieldView.bottomAnchor, constant: 25),
            dateTextFieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateTextFieldView.heightAnchor.constraint(equalToConstant: 75),
            dateTextFieldView.widthAnchor.constraint(equalToConstant: 325)
        ])
    }
    
    func configureDoneButton() {
        view.addSubview(doneButton)
        
        doneButton.addTarget(self, action: #selector(doneButtonHandler), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: dateTextFieldView.bottomAnchor, constant: 30),
            doneButton.leadingAnchor.constraint(equalTo: dateTextFieldView.leadingAnchor, constant: 30),
            doneButton.trailingAnchor.constraint(equalTo: dateTextFieldView.trailingAnchor, constant: -30),
            doneButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    @objc func doneButtonHandler() {
        dateTextFieldView.donePressed()
        guard let number = phoneNumberTextFieldView.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard let date = dateTextFieldView.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard let car = car else { return }
        
        phoneNumberTextFieldView.checkIsEmpty()
        dateTextFieldView.checkIsEmpty()
        
        if number != "" && date != "" {
            
            let newAppointment = Appointment(uid: UUID(), car: car.uid.uuidString, carOwner: car.owner, phoneNumber: number, date: date)
            showLoadingView()
            FirestoreManager.createAppointment(appointment: newAppointment) { [weak self] result in
                guard let self = self else { return }
                self.dismissLoadingView()
                switch result {
                case .success(let string):
                    print(string)
                    self.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    
    func configureCancelButton() {
        view.addSubview(cancelButton)
        
        cancelButton.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            cancelButton.bottomAnchor.constraint(equalTo: doneButton.bottomAnchor, constant: 50),
            cancelButton.leadingAnchor.constraint(equalTo: dateTextFieldView.leadingAnchor, constant: 30),
            cancelButton.trailingAnchor.constraint(equalTo: dateTextFieldView.trailingAnchor, constant: -30),
            cancelButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    @objc func handleCancelButton() {
        navigationController?.popViewController(animated: true)
    }
    
    
    func configureView() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        view.backgroundColor = Colors.darkBlue
        view.isUserInteractionEnabled = true
    }
    
    
    func addTapGesture(view: CSATextFieldView) {
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func handleTap(sender: UIGestureRecognizer) {
        if let view = sender.view as? CSATextFieldView{
            view.textField.becomeFirstResponder()
        }
    }
    
}

extension SetAppointmentVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == phoneNumberTextFieldView.textField {
            textField.resignFirstResponder()
            dateTextFieldView.textField.becomeFirstResponder()
        } else if textField == dateTextFieldView.textField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == phoneNumberTextFieldView.textField {
            phoneNumberTextFieldView.checkIsEmpty()
        } else if textField == dateTextFieldView.textField {
            dateTextFieldView.checkIsEmpty()
        }
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == phoneNumberTextFieldView.textField {
            phoneNumberTextFieldView.setColor(with: .white)
        } else if textField == dateTextFieldView.textField {
            dateTextFieldView.setColor(with: .white)
        }
        return true
    }
    
}


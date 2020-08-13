//
//  CSATextFieldView.swift
//  Car Service App
//
//  Created by Murat Baykor on 27.07.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

enum TextFieldType {
    case email, password, name, phone, appointment
}

protocol CSATextFieldViewDelegate {
    func handleForgotPasswordButton()
}

class CSATextFieldView: UIView {
    
    let textFieldTitle = CSATextFieldTitleLabel()
    let textField = CSATextField()
    let forgotPasswordButton = CSATextButton(title: "Forgot Password", color: .lightGray)
    let lineView = CSALineView()
    
    var delegate: CSATextFieldViewDelegate?
    
    let datePicker = UIDatePicker()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        configureTextFieldTitle()
        configureTextField()
        configureLineView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureTextFieldTitle() {
        addSubview(textFieldTitle)
        
        NSLayoutConstraint.activate([
            textFieldTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            textFieldTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            textFieldTitle.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    
    private func configureTextField() {
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: textFieldTitle.bottomAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: textFieldTitle.leadingAnchor),
            textField.widthAnchor.constraint(equalToConstant: 305),
            textField.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
    private func configureLineView() {
        addSubview(lineView)
   
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8),
            lineView.leadingAnchor.constraint(equalTo: textFieldTitle.leadingAnchor),
            lineView.widthAnchor.constraint(equalToConstant: 305),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    
    private func configureForgotPasswordButton() {
        addSubview(forgotPasswordButton)
        
        forgotPasswordButton.addTarget(self, action: #selector(handleForgotPassword), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 8),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: lineView.trailingAnchor),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 27)
        ])
    }
    
    
    @objc func handleForgotPassword() {
        delegate?.handleForgotPasswordButton()
    }
    
    
    func checkIsEmpty() {
        if textField.text == "" {
            setColor(with: .systemRed)
        } else {
            setColor(with: .white)
        }
    }
    
    
    func setColor(with color: UIColor) {
        textFieldTitle.setColor(with: color)
        lineView.setColor(with: color)
    }
    
    
    private func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        textField.inputAccessoryView = toolbar
        
        textField.inputView = datePicker
        datePicker.datePickerMode = .dateAndTime
    }
    
    
    @objc func donePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        textField.text = formatter.string(from: datePicker.date)

        self.endEditing(true)
    }

    
    func set(textFieldType: TextFieldType, forgotPasswordOn: Bool = false) {
        
        switch textFieldType {
        case .email:
            textFieldTitle.text = "Email"
            textField.textContentType = .emailAddress
            textField.keyboardType = .emailAddress
        case .password:
            textFieldTitle.text = "Password"
            textField.keyboardType = .default
            textField.textContentType = .password
            textField.isSecureTextEntry = true
            if forgotPasswordOn {
                configureForgotPasswordButton()
            }
        case .name:
            textFieldTitle.text = "Name"
            textField.textContentType = .name
            textField.keyboardType = .default
        case .phone:
            textFieldTitle.text = "Phone Number"
            textField.textContentType = .telephoneNumber
            textField.keyboardType = .numberPad
        case .appointment:
            textFieldTitle.text = "Set Date"
            createDatePicker()
        }
        
    }
    
    
}

//
//  RegisterVC.swift
//  Car Service App
//
//  Created by Murat Baykor on 27.07.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    
    let titleLabel = CSATitleLabel()
    let nameTextFieldView = CSATextFieldView()
    let emailTextFieldView = CSATextFieldView()
    let passwordTextFieldView = CSATextFieldView()
    let registerButton = CSAAuthButton(title: "Sign up")
    let loginButton = CSATextButton(title: "Do you have a account? Login!", color: Colors.softBlue)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configurenNameTextFieldView()
        configureEmailTextFieldView()
        configurePasswordTextFieldView()
        configureTitleLabel()
        configureRegisterButton()
        configureLoginButton()
        
    }
    
    func configureView() {
        view.backgroundColor = Colors.darkBlue
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleViewTap)))
    }
    
    
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.text = "Create account"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 125),
            titleLabel.leadingAnchor.constraint(equalTo: nameTextFieldView.leadingAnchor, constant: 10)
        ])
    }
    
    
    func configurenNameTextFieldView() {
        view.addSubview(nameTextFieldView)
        addTapGesture(view: nameTextFieldView)
        nameTextFieldView.set(textFieldType: .name)
        nameTextFieldView.textField.delegate = self
        
        NSLayoutConstraint.activate([
            nameTextFieldView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            nameTextFieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextFieldView.heightAnchor.constraint(equalToConstant: 75),
            nameTextFieldView.widthAnchor.constraint(equalToConstant: 325)
        ])
    }
    
    func configureEmailTextFieldView() {
        view.addSubview(emailTextFieldView)
        addTapGesture(view: emailTextFieldView)
        emailTextFieldView.set(textFieldType: .email)
        emailTextFieldView.textField.delegate = self
        
        NSLayoutConstraint.activate([
            emailTextFieldView.topAnchor.constraint(equalTo: nameTextFieldView.bottomAnchor, constant: 25),
            emailTextFieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextFieldView.heightAnchor.constraint(equalToConstant: 75),
            emailTextFieldView.widthAnchor.constraint(equalToConstant: 325)
        ])
    }
    
    func configurePasswordTextFieldView() {
        view.addSubview(passwordTextFieldView)
        addTapGesture(view: passwordTextFieldView)
        passwordTextFieldView.set(textFieldType: .password)
        passwordTextFieldView.textField.delegate = self
        
        NSLayoutConstraint.activate([
            passwordTextFieldView.topAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: 25),
            passwordTextFieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextFieldView.heightAnchor.constraint(equalToConstant: 75),
            passwordTextFieldView.widthAnchor.constraint(equalToConstant: 325)
        ])
    }
    
    
    func configureRegisterButton() {
        view.addSubview(registerButton)
        
        registerButton.addTarget(self, action: #selector(showMain), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: 60),
            registerButton.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 30),
            registerButton.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -30),
            registerButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    
    func configureLoginButton() {
        view.addSubview(loginButton)
        
        loginButton.addTarget(self, action: #selector(showLogin), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            loginButton.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -30),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    @objc func showMain(){
        view.endEditing(true)
        guard let name = nameTextFieldView.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard let email = emailTextFieldView.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard let password = passwordTextFieldView.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        
        nameTextFieldView.checkIsEmpty()
        emailTextFieldView.checkIsEmpty()
        passwordTextFieldView.checkIsEmpty()
        
        if name == "" || email == "" || password == "" {
            print("fill empty field")
        } else {
            
            let user = User(name: name, email: email, password: password)
            
            AuthManager.register(with: user) { [weak self] result in
                guard self != nil else { return }
                switch result {
                case .success(let uid):
                    print(uid)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        
        
    }
    
    @objc func showLogin(){
        navigationController?.popToRootViewController(animated: true)
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
    
    @objc func handleViewTap() {
        view.endEditing(true)
    }
    
}

extension RegisterVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextFieldView.textField {
            textField.resignFirstResponder()
            emailTextFieldView.textField.becomeFirstResponder()
        } else if textField == emailTextFieldView.textField {
            textField.resignFirstResponder()
            passwordTextFieldView.textField.becomeFirstResponder()
        } else if textField == passwordTextFieldView.textField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameTextFieldView.textField {
            nameTextFieldView.checkIsEmpty()
        } else if textField == emailTextFieldView.textField {
            emailTextFieldView.checkIsEmpty()
        } else if textField == passwordTextFieldView.textField {
            passwordTextFieldView.checkIsEmpty()
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == nameTextFieldView.textField {
            nameTextFieldView.setNormalColor()
        } else if textField == emailTextFieldView.textField {
            emailTextFieldView.setNormalColor()
        } else if textField == passwordTextFieldView.textField {
            passwordTextFieldView.setNormalColor()
        }
        return true
    }
 
    
}

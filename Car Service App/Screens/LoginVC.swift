//
//  LoginVC.swift
//  Car Service App
//
//  Created by Murat Baykor on 27.07.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class LoginVC: CSALoadingVC  {
    
    let logoImageView = UIImageView()
    let emailTextFieldView = CSATextFieldView()
    let passwordTextFieldView = CSATextFieldView()
    let loginButton = CSAAuthButton(title: "Login")
    let registerButton = CSATextButton(title: "Don't have a account? Sign up!", color: Colors.softBlue)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureLogoImageView()
        configureEmailTextFieldView()
        configurePasswordTextFieldView()
        configureLoginButton()
        configureRegisterButton()
    }
    
    
    private func configureView() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = Colors.darkBlue
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleViewTap)))
    }
    
    
    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "default")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 65),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    private func configureEmailTextFieldView() {
        view.addSubview(emailTextFieldView)
        
        emailTextFieldView.set(textFieldType: .email)
        emailTextFieldView.textField.delegate = self
        addTapGesture(view: emailTextFieldView)
        
        NSLayoutConstraint.activate([
            emailTextFieldView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 15),
            emailTextFieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextFieldView.heightAnchor.constraint(equalToConstant: 75),
            emailTextFieldView.widthAnchor.constraint(equalToConstant: 325)
        ])
    }
    
    
    private func configurePasswordTextFieldView() {
        view.addSubview(passwordTextFieldView)
        
        passwordTextFieldView.set(textFieldType: .password, forgotPasswordOn: true)
        passwordTextFieldView.textField.delegate = self
        passwordTextFieldView.delegate = self
        addTapGesture(view: passwordTextFieldView)
        
        NSLayoutConstraint.activate([
            passwordTextFieldView.topAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: 25),
            passwordTextFieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextFieldView.heightAnchor.constraint(equalToConstant: 105),
            passwordTextFieldView.widthAnchor.constraint(equalToConstant: 325)
        ])
    }
    
    
    private func configureLoginButton() {
        view.addSubview(loginButton)
        
        loginButton.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: 40),
            loginButton.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -30),
            loginButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    
    private func configureRegisterButton() {
        view.addSubview(registerButton)
        
        registerButton.addTarget(self, action: #selector(showRegister), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            registerButton.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 30),
            registerButton.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -30),
            registerButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    @objc func handleLoginButton(){
        view.endEditing(true)
        guard let email = emailTextFieldView.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard let password = passwordTextFieldView.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        
        emailTextFieldView.checkIsEmpty()
        passwordTextFieldView.checkIsEmpty()
        
        if email != "" && password != "" {
            showLoadingView()
            AuthManager.login(withemail: email, password: password) { [weak self] result in
                guard let self = self else { return }
                self.dismissLoadingView()
                switch result {
                case .success(_):
                    self.presentMyAccountVC()
                case .failure(let error):
                    self.presentAlertWithOk(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
    
    
    private func presentMyAccountVC() {
        let myAccountVC = MyAccountVC()
        self.navigationController?.pushViewController(myAccountVC, animated: true)
    }
    
    
    @objc func showRegister(){
        let registerVC = RegisterVC()
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    
    private func addTapGesture(view: CSATextFieldView) {
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


extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextFieldView.textField {
            textField.resignFirstResponder()
            passwordTextFieldView.textField.becomeFirstResponder()
        } else if textField == passwordTextFieldView.textField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextFieldView.textField {
            emailTextFieldView.checkIsEmpty()
        } else if textField == passwordTextFieldView.textField {
            passwordTextFieldView.checkIsEmpty()
        }
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == emailTextFieldView.textField {
            emailTextFieldView.setColor(with: .white)
        } else if textField == passwordTextFieldView.textField {
            passwordTextFieldView.setColor(with: .white)
        }
        return true
    }
    
    
}


extension LoginVC: CSATextFieldViewDelegate {
    func handleForgotPasswordButton() {
        let forgotPasswordVC = ForgotPasswordVC()
        forgotPasswordVC.emailTextFieldView.textField.text = emailTextFieldView.textField.text
        navigationController?.pushViewController(forgotPasswordVC, animated: true)
    }
}

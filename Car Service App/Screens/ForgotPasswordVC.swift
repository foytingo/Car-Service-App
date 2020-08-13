//
//  ForgotPasswordVC.swift
//  Car Service App
//
//  Created by Murat Baykor on 29.07.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class ForgotPasswordVC: CSALoadingVC {
    
    let titleLabel = CSATitleLabel()
    let emailTextFieldView = CSATextFieldView()
    let resetPasswordButton = CSAAuthButton(title: "Reset password")
    let loginButton = CSATextButton(title: "Do you remember password? Login!", color: Colors.softBlue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureEmailTextFieldView()
        configureTitleLabel()
        configureResetPasswordButtonButton()
        configureLoginButton()
    }
    
    
    func configureView() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = Colors.darkBlue
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleViewTap)))
    }
    
    
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.text = "Reset password"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 125),
            titleLabel.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 10)
        ])
    }
    
    
    func configureEmailTextFieldView() {
        view.addSubview(emailTextFieldView)
        
        addTapGesture(view: emailTextFieldView)
        emailTextFieldView.set(textFieldType: .email)
        emailTextFieldView.textField.delegate = self
        
        NSLayoutConstraint.activate([
            emailTextFieldView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            emailTextFieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextFieldView.heightAnchor.constraint(equalToConstant: 75),
            emailTextFieldView.widthAnchor.constraint(equalToConstant: 325)
        ])
    }
    
    
    func configureResetPasswordButtonButton() {
        view.addSubview(resetPasswordButton)
        
        resetPasswordButton.addTarget(self, action: #selector(resetPassword), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            resetPasswordButton.topAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: 60),
            resetPasswordButton.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 30),
            resetPasswordButton.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -30),
            resetPasswordButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    
    func configureLoginButton() {
        view.addSubview(loginButton)
        
        loginButton.addTarget(self, action: #selector(showLogin), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: resetPasswordButton.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -30),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    @objc func showLogin(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    @objc func resetPassword(){
        view.endEditing(true)
        guard let email = emailTextFieldView.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        
        emailTextFieldView.checkIsEmpty()
        
        if email != "" {
            showLoadingView()
            AuthManager.forgotPassword(withEmail: email) { [weak self] result in
                guard let self = self else { return }
                self.dismissLoadingView()
                
                switch result {
                case .success(let message):
                    self.presentAlertWithOkAction(title: "Password Reset", message: message) { action in
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                case .failure(let error):
                    self.presentAlertWithOk(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
    
    
    @objc func handleViewTap() {
        view.endEditing(true)
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


extension ForgotPasswordVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextFieldView.textField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextFieldView.textField {
            emailTextFieldView.checkIsEmpty()
        }
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == emailTextFieldView.textField {
            emailTextFieldView.setColor(with: .white)
        }
        return true
    }
    
    
}

//
//  ForgotPasswordVC.swift
//  Car Service App
//
//  Created by Murat Baykor on 29.07.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    let titleLabel = CSATitleLabel()
    let emailTextFieldView = CSATextFieldView()
    let resetPasswordButton = CSAAuthButton(title: "Reset Password")
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
           
           titleLabel.text = "Reset Password"
           
           NSLayoutConstraint.activate([
               titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
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
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            loginButton.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -30),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func showLogin(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func resetPassword(){
           print("show alert and back")
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
}

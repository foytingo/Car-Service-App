//
//  LoginVC.swift
//  Car Service App
//
//  Created by Murat Baykor on 27.07.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    let logoImageView = UIImageView()
    let emailTextFieldView = CSATextFieldView()
    let passwordTextFieldView = CSATextFieldView()
    let loginButton = CSAAuthButton(title: "Login")
    let registerButton = CSATextButton(title: "Don't have a account? Sign up!")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLogoImageView()
        configureEmailTextFieldView()
        configurePasswordTextFieldView()
        configureLoginButton()
        configureRegisterButton()
        view.backgroundColor = UIColor(red: 0.09, green: 0.11, blue: 0.38, alpha: 1.00)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "default")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 75),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    func configureEmailTextFieldView() {
        view.addSubview(emailTextFieldView)
        
        emailTextFieldView.set(textFieldType: .email)
        
        NSLayoutConstraint.activate([
            emailTextFieldView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 25),
            emailTextFieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextFieldView.heightAnchor.constraint(equalToConstant: 75),
            emailTextFieldView.widthAnchor.constraint(equalToConstant: 275)
        ])
    }
    
    
    func configurePasswordTextFieldView() {
        view.addSubview(passwordTextFieldView)
        
        passwordTextFieldView.set(textFieldType: .password)
        
        NSLayoutConstraint.activate([
            passwordTextFieldView.topAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: 25),
            passwordTextFieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextFieldView.heightAnchor.constraint(equalToConstant: 75),
            passwordTextFieldView.widthAnchor.constraint(equalToConstant: 275)
        ])
    }
    
    
    func configureLoginButton() {
        view.addSubview(loginButton)
        
         loginButton.addTarget(self, action: #selector(showMain), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: 60),
            loginButton.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -30),
            loginButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func configureRegisterButton() {
        view.addSubview(registerButton)
        
        registerButton.addTarget(self, action: #selector(showRegister), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            registerButton.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 30),
            registerButton.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -30),
            registerButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc func showMain(){
        print("Login")
    }
    
    @objc func showRegister(){
        print("Register")
    }
    
}

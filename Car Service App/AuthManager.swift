//
//  AuthManager.swift
//  Car Service App
//
//  Created by Murat Baykor on 29.07.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import Foundation
import Firebase

struct AuthManager {
    
    
    static func register(with userData: User, completed: @escaping(Result<String, Error>) -> Void) {
        
        Auth.auth().createUser(withEmail: userData.email, password: userData.password) { result, error in
            if let error = error {
                completed(.failure(error))
            }
            
            guard let uid = result?.user.uid else { return }
            
            let values = ["uid": uid, "email": userData.email, "name": userData.name]
            
            Firestore.firestore().collection("users").addDocument(data: values) { (error) in
                if let error = error {
                    completed(.failure(error))
                }
            }
            
            guard let user = result?.user else { return }
            
            user.sendEmailVerification { error in
                if let error = error {
                    completed(.failure(error))
                }
            }
            completed(.success(user.uid))
        }
    }
    
    
    static func forgotPassword(withEmail email: String, completed: @escaping(Result<String, Error>) -> Void) {
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completed(.failure(error))
            }
            completed(.success("Pasword reset email sent."))
        }
    }
    
    
    
    static func login(withemail email: String, password: String, completed: @escaping(Result<String, Error>) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completed(.failure(error))
            }
            
            guard let user = result?.user else { return }
            completed(.success(user.uid))
        }
        
    }
}

//
//  User.swift
//  Car Service App
//
//  Created by Murat Baykor on 29.07.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import Foundation

struct User {
    var uid: String?
    var name: String
    var email: String
    var password: String
    var cars: [String] = []
    
    init(name: String, email: String, password: String, uid: String? = nil) {
        self.name = name
        self.email = email
        self.password = password
  
    }
}

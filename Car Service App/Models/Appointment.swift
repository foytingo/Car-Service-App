//
//  Appointment.swift
//  Car Service App
//
//  Created by Murat Baykor on 11.08.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import Foundation

struct Appointment {
    
    var uid: UUID
    var car: String
    var carOwner: String
    var phoneNumber: String
    var date: String

    
    init (uid: UUID, car: String, carOwner: String, phoneNumber: String, date: String) {
        self.uid = uid
        self.car = car
        self.carOwner = carOwner
        self.phoneNumber = phoneNumber
        self.date = date
    }
    
    
    init (uid: UUID, dictionary: [String: Any]) {
        self.uid = uid
        self.car = dictionary["car"] as? String ?? ""
        self.carOwner = dictionary["carOwner"] as? String ?? ""
        self.phoneNumber = dictionary["number"] as? String ?? ""
        self.date = dictionary["date"] as? String ?? ""
    }
    

}



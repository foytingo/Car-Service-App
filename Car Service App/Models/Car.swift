//
//  Car.swift
//  Car Service App
//
//  Created by Murat Baykor on 5.08.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import Foundation

struct Car {
    var owner: String
    var uid: UUID
    var brand: String
    var year: String
    var model: String
    var color: String
    var plateNumber: String
    var currentKm: String
    
    init (owner: String, uid: UUID, brand: String, year: String, model: String, color: String, plateNumber: String, currentKm: String) {
        self.owner = owner
        self.uid = uid
        self.brand = brand
        self.year = year
        self.model = model
        self.color = color
        self.plateNumber = plateNumber
        self.currentKm = currentKm
    }
    
    init (uid: UUID, dictionary: [String: Any]) {
        self.uid = uid
        self.brand = dictionary["brand"] as? String ?? ""
        self.year = dictionary["year"] as? String ?? ""
        self.model = dictionary["mdoel"] as? String ?? ""
        self.color = dictionary["color"] as? String ?? ""
        self.plateNumber = dictionary["plateNumber"] as? String ?? ""
        self.currentKm = dictionary["currentKm"] as? String ?? ""
        self.owner = dictionary["owner"] as? String ?? ""
    }
}

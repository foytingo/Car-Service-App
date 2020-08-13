//
//  Constants.swift
//  Car Service App
//
//  Created by Murat Baykor on 27.07.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit
import Firebase

enum Colors {
    static let darkBlue = UIColor(red: 0.09, green: 0.11, blue: 0.38, alpha: 1.00)
    static let softBlue = UIColor(red: 0.15, green: 0.74, blue: 0.84, alpha: 1.00)
    static let backgroundBlue = UIColor(red: 0.20, green: 0.22, blue: 0.35, alpha: 1.00)
    static let backgroundBlue2 = UIColor(red: 0.16, green: 0.18, blue: 0.33, alpha: 1.00)
}


enum FirestoreCollections {
    static let users = Firestore.firestore().collection("users")
    static let cars = Firestore.firestore().collection("cars")
    static let appointments = Firestore.firestore().collection("appointments")
}


enum Arrays {
    static let carBrands = ["Audi", "Volkswagen", "Seat", "Skoda", "Porsche"]
    static let modelYears = ["2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020"]
    static let audiModels = ["A1", "A3", "A4", "A5", "A6", "A7", "A8", "Q2", "Q3", "Q5", "Q7", "Q8", "R8", "TT"]
    static let volkswagenModels = ["Amarok", "Ameo", "Arteon", "Atlas (Teramont)","Caddy", "California", "Fox", "Golf", "ID.3", "Jetta", "Lamando", "Lavida", "Passat", "Polo", "Santana", "Scirocco", "Sharan", "T-Cross", "Tiguan", "Touareg", "Touran", "Transporter", "T-Roc", "Up", "Vento", "XL 1"]
    static let seatModels = ["Ibiza", "Alhambra", "Mii", "Leon", "Ateca", "Arona", "Tarraco", "Exeo"]
    static let skodaModels = ["Octavia","Kodiaq", "Karoq","Kamiq","Scala", "Citigo", "Fabia","Superb","Rapid","Yeti" ]
    static let porscheModels = ["911", "Cayenne", "Cayman", "Panamera", "918 Spyder", "Macan", "Taycan"]
    static let colors = ["Black", "White", "Grey", "Red", "Blue", "Yellow", "Orange", "Green", "Purple", "Pink"]
}

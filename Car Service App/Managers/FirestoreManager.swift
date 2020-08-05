//
//  FirestoreManager.swift
//  Car Service App
//
//  Created by Murat Baykor on 5.08.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import Foundation
import Firebase

struct FirestoreManager {
    
    static func uploadCar(userUid: String, car carData: Car, completed: @escaping(Result<String, Error>) -> Void) {
        
        let values = ["owner": userUid, "carID": carData.uid.uuidString, "brand": carData.brand, "year": carData.year, "mdoel": carData.model, "color": carData.color, "plateNumber": carData.plateNumber, "currentKm": carData.currentKm]
 
        
        
        Firestore.firestore().collection("cars").document(carData.uid.uuidString).setData(values) { (error) in
            if let error = error {
                completed(.failure(error))
            }
            Firestore.firestore().collection("users").document(userUid).updateData(["cars": FieldValue.arrayUnion([carData.uid.uuidString])])
        }
        completed(.success(userUid))
    }
    
    
}

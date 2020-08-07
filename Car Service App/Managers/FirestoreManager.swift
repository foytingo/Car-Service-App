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
    
    static func fetchUser(uid: String, completed: @escaping(Result<User, Error>) -> Void) {
        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, error) in
            guard let dictionary = snapshot?.data() else { return }
            
            let user = User(uid: uid, dictionary: dictionary)
            if let error = error {
                completed(.failure(error))
            }
            completed(.success(user))
        }
    }
    
    static func fetchCar(uid: String, completed: @escaping(Result<Car, Error>) -> Void) {
        Firestore.firestore().collection("cars").document(uid).getDocument { (snapshot, error) in
            guard let dictionary = snapshot?.data() else { return }
            
            let car = Car(uid: UUID(uuidString: uid)!, dictionary: dictionary)
            if let error = error {
                completed(.failure(error))
            }
            completed(.success(car))
        }
    }
        
    
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
    
    static func updateKm(currentKM: String, car carData: Car, completed: @escaping(Result<String, Error>) -> Void) {
        Firestore.firestore().collection("cars").document(carData.uid.uuidString).updateData(["currentKm" : currentKM]) { error in
            if let error = error {
                completed(.failure(error))
            } else {
                completed(.success(currentKM))
            }
        }
    }
    
}

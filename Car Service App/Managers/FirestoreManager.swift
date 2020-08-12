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
    
    static func fetcAppointments(uid: String, car: Car, completed: @escaping(Result<Appointment, Error>) -> Void) {
        Firestore.firestore().collection("appointments").document(uid).getDocument { (snapshot, error) in
            guard let dictionary = snapshot?.data() else { return }
            
            let appointment = Appointment(uid: UUID(uuidString: uid)!, dictionary: dictionary)
            if let error = error {
                completed(.failure(error))
            }
            completed(.success(appointment))
        }
    }
        
    
    static func uploadCar(userUid: String, car carData: Car, completed: @escaping(Result<String, Error>) -> Void) {
        
        let values = ["owner": userUid, "carID": carData.uid.uuidString, "brand": carData.brand, "year": carData.year, "model": carData.model, "color": carData.color, "plateNumber": carData.plateNumber, "currentKm": carData.currentKm, "appointment": carData.appointments] as [String : Any]
        
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
    
    static func createAppointment(appointment: Appointment, completed: @escaping(Result<String, Error>) -> Void) {
        
        let values = ["uid": appointment.uid.uuidString,
                      "car": appointment.car,
                      "carOwner": appointment.carOwner,
                      "number": appointment.phoneNumber,
                      "date": appointment.date]
        
        Firestore.firestore().collection("appointments").document(appointment.uid.uuidString).setData(values) { (error) in
            if let error = error {
                completed(.failure(error))
            }
            Firestore.firestore().collection("users").document(appointment.carOwner).updateData(["appointment": FieldValue.arrayUnion([appointment.uid.uuidString])])
            
            Firestore.firestore().collection("cars").document(appointment.car).updateData(["appointment": FieldValue.arrayUnion([appointment.uid.uuidString])])
        }
        completed(.success("success"))
    }
    
    
    static func deleteAppointment(appointmentUid: String, completed: @escaping(Result<String,Error>) -> Void) {
        Firestore.firestore().collection("appointments").document(appointmentUid).delete { error in
            if let error = error {
                completed(.failure(error))
            }
            completed(.success("\(appointmentUid) was successfullt deleted."))
        }
    }
 
    
    static func deleteCar(carUid: String, completed: @escaping(Result<String,Error>) -> Void) {
        Firestore.firestore().collection("cars").document(carUid).getDocument { (snapshot, error) in
            
            if let error = error {
                completed(.failure(error))
            }
            
            guard let dictionary = snapshot?.data() else { return }
            
            let car = Car(uid: UUID(uuidString: carUid)!, dictionary: dictionary)
            
            for appointment in car.appointments {
                Firestore.firestore().collection("appointments").document(appointment).delete { error in
                    if let error = error {
                        completed(.failure(error))
                    }
                }
            }
            
            Firestore.firestore().collection("cars").document(carUid).delete { (error) in
                if let error = error {
                    completed(.failure(error))
                }
            }
            
            Firestore.firestore().collection("users").document(car.owner).updateData(["cars": FieldValue.arrayRemove([carUid]), "appointment": FieldValue.arrayRemove(car.appointments)]) { error in
                if let error = error {
                    completed(.failure(error))
                }
            }
            
            completed(.success("Cars and appointment successfully deleted."))
        }
        
    }
    
    
}

//
//  MyaccountVC+Ext.swift
//  Car Service App
//
//  Created by Murat Baykor on 8.08.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

extension MyAccountVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarCell.reuseID, for: indexPath) as! CarCell
        cell.set(car: cars[indexPath.row])
        cell.carCellDelegate = self
        return cell
    }
    
}

extension MyAccountVC: CarCellDelegate {
    
    func didTapActionButton(_ cell: CarCell) {
        let indexPath = carsTableView.indexPath(for: cell)!
        let car = cars[indexPath.row]
        
        let ac = UIAlertController(title: car.plateNumber.uppercased(), message: "Select action", preferredStyle: .actionSheet)
        
        let appointment = UIAlertAction(title: "Set Appointment", style: .default) { [weak self] action in
            guard let self = self else { return }
            let destVC = SetAppointmentVC()
            destVC.car = car
            self.navigationController?.pushViewController(destVC, animated: true)
        }
        
        let showAppointment = UIAlertAction(title: "Show Appointments", style: .default) { [weak self] action in
            guard let self = self else { return }
            let destVC = ShowAppointmentsVC()
            destVC.car = car
            self.navigationController?.pushViewController(destVC, animated: true)
        }
        
        let updateKM = UIAlertAction(title: "Update Kilometer", style: .default) { [weak self] action in
            guard let self = self else { return }
            self.presentAlertWithTextField(title: "Update Kilometer", message: "Update this car kilometer", placeholder: "Enter current km") { newCurrentKm in
                self.showLoadingView()
                if Int(newCurrentKm) ?? 0 < Int(self.cars[indexPath.row].currentKm) ?? 0 {
                    self.dismissLoadingView()
                    self.presentAlertWithOk(title: "Error", message: "You can not enter lower kilometer than current kilometer.")
                } else {
                    FirestoreManager.updateKm(currentKM: newCurrentKm, car: cell.car!) { [weak self] result in
                        guard let self = self else {return}
                        self.dismissLoadingView()
                        switch result {
                        case .success(let currentKm):
                            self.cars[indexPath.row].currentKm = currentKm
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
                
            }
        }
        
        let deleteCar = UIAlertAction(title: "Delete", style: .destructive) { [weak self] action in
            guard let self = self else { return }
            self.presentAlertWithDeleteAction(title: "Are you sure?", message: "If you delete this car, appointments will delete.", handler: { action in
                self.showLoadingView()
                FirestoreManager.deleteCar(carUid: car.uid.uuidString) { [weak self] result in
                    guard let self = self else { return }
                    self.dismissLoadingView()
                    switch result {
                    case .success(let message):
                        self.cars.remove(at: indexPath.row)
                        print(message)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            })
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(updateKM)
        ac.addAction(showAppointment)
        ac.addAction(appointment)
        ac.addAction(deleteCar)
        ac.addAction(cancelAction)
        
        self.present(ac, animated: true, completion: nil)
        
    }
    
    
}


extension MyAccountVC: MainHeaderViewDelegate {
    
    func didTapSettingsButton() {
        presentActionSheetUserSettings(title: "Settings", message: "Select Action")
    }
}

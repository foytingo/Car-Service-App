//
//  MainVC.swift
//  Car Service App
//
//  Created by Murat Baykor on 29.07.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit
import Firebase

class MainVC: CSALoadingVC {
    
    let user = Auth.auth().currentUser
    var cars = [Car]() {
        didSet {
            carsTableView.reloadData()
            
        }
    }
    
    let headerTitleLabel = CSATitleLabel()
    let headerView = MainHeaderView()
    let carsTitleLabel = CSATitleLabel()
    let carsTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let user = user else { return }
        DispatchQueue.global(qos: .userInitiated).async {
            self.fetchUser(with: user.uid)
        }
        
        configureView()
        configureHeaderTitleLabel()
        configureHeaderView()
        configureCarsTitleLabel()
        configureCarsTableView()
        
        
    }
    
    func fetchUser(with uid: String) {
        showLoadingView()
        FirestoreManager.fetchUser(uid: uid) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.headerView.set(user: user, verifyStatus: self.user?.isEmailVerified)
                self.fetchUsersCars(with: user)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchUsersCars(with user: User) {
        for car in user.cars {
            FirestoreManager.fetchCar(uid: car) { [weak self] result in
                guard let self = self else { return }
                self.dismissLoadingView()
                switch result {
                case .success(let car):
                    self.cars.append(car)
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        
    }
    
    func configureView() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = Colors.darkBlue
        
    }
    
    func configureHeaderTitleLabel() {
        view.addSubview(headerTitleLabel)
        
        headerTitleLabel.text = "My Account"
        
        NSLayoutConstraint.activate([
            headerTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            headerTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
    
    func configureHeaderView() {
        view.addSubview(headerView)
        headerView.mainHeaderViewDelegate = self
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: headerTitleLabel.bottomAnchor, constant: 10),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            headerView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func configureCarsTitleLabel(){
        view.addSubview(carsTitleLabel)
        
        carsTitleLabel.text = "My Cars"
        
        NSLayoutConstraint.activate([
            carsTitleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30),
            carsTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
    
    func configureCarsTableView() {
        view.addSubview(carsTableView)
        carsTableView.rowHeight = 100
        carsTableView.separatorStyle = .none
        carsTableView.allowsSelection = false
        carsTableView.backgroundColor = Colors.darkBlue
        carsTableView.translatesAutoresizingMaskIntoConstraints = false
        carsTableView.register(CarCell.self, forCellReuseIdentifier: CarCell.reuseID)
        carsTableView.delegate = self
        carsTableView.dataSource = self
        
        NSLayoutConstraint.activate([
            carsTableView.topAnchor.constraint(equalTo: carsTitleLabel.bottomAnchor, constant: 10),
            carsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            carsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            carsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
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

extension MainVC: CarCellDelegate {
    func didTapActionButton() {
        //change with textfieldalert
        presentAlertWithOk(title: "Update KM", message: "km textfield was here")
    }
}

extension MainVC: MainHeaderViewDelegate {
    func didTapSettingsButton() {
        //change with settings page
        do{
            try Auth.auth().signOut()
             navigationController?.popToRootViewController(animated: true)
        } catch let error {
            print("Failed to sing out \(error.localizedDescription)")
        }
        
       
    }
    
    
}

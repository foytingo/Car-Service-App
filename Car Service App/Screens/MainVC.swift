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
            DispatchQueue.main.async {
                self.carsTableView.reloadData()
            }
        }
    }
    
    let headerTitleLabel = CSATitleLabel()
    let headerView = MainHeaderView()
    let carsTitleLabel = CSATitleLabel()
    let addCarButton = CSATextButton(title: "Add Car", color: Colors.softBlue)
    let carTableViewTitleStackView = UIStackView()
    let carsTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureView()
        configureHeaderTitleLabel()
        configureHeaderView()
        configureCarsTitleLabel()
        configureAddCarButton()
        configureStackView()
        configureCarsTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let user = user else { return }
        DispatchQueue.global(qos: .userInitiated).async {
            self.cars.removeAll()
            self.fetchUser(with: user.uid)
        }
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
        carsTitleLabel.text = "My Cars"
    }
    
    func configureAddCarButton() {
        addCarButton.addTarget(self, action: #selector(handleAddCarButton), for: .touchUpInside)
    }
    
    @objc func handleAddCarButton() {
        let destVC = AddCarVC()
        destVC.uid = user?.uid
        destVC.isComingInApp = true
        let navController = UINavigationController(rootViewController: destVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    func configureStackView() {
        view.addSubview(carTableViewTitleStackView)
        
        carTableViewTitleStackView.translatesAutoresizingMaskIntoConstraints = false
        carTableViewTitleStackView.axis = .horizontal
        carTableViewTitleStackView.distribution = .fill
        carTableViewTitleStackView.addArrangedSubview(carsTitleLabel)
        carTableViewTitleStackView.addArrangedSubview(addCarButton)
        
        NSLayoutConstraint.activate([
            carTableViewTitleStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30),
            carTableViewTitleStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            carTableViewTitleStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
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
            carsTableView.topAnchor.constraint(equalTo: carTableViewTitleStackView.bottomAnchor, constant: 10),
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
    func didTapActionButton(_ cell: CarCell) {
        let indexPath = carsTableView.indexPath(for: cell)!
        
        presentAlertWithTextField(title: "Update Kilometer", message: "Update this car kilometer", placeholder: "Enter current km") { newCurrentKm in
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
    
}

extension MainVC: MainHeaderViewDelegate {
    func didTapSettingsButton() {
        presentActionSheetUserSettings(title: "Settings", message: "Select Action")
        
    }
    
    
}

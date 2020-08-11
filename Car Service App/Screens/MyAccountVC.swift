//
//  MainVC.swift
//  Car Service App
//
//  Created by Murat Baykor on 29.07.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit
import Firebase

class MyAccountVC: CSALoadingVC {
    
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
        configureCarTableViewTitleStackView()
        configureCarsTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let user = user else { return }
        DispatchQueue.global(qos: .userInitiated).async {
            self.cars.removeAll()
            self.fetchUser(with: user.uid)
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
    
    
    func configureCarTableViewTitleStackView() {
        view.addSubview(carTableViewTitleStackView)
        
        carsTitleLabel.text = "My Cars"
        addCarButton.addTarget(self, action: #selector(handleAddCarButton), for: .touchUpInside)
        
        carTableViewTitleStackView.translatesAutoresizingMaskIntoConstraints = false
        carTableViewTitleStackView.axis = .horizontal
        carTableViewTitleStackView.distribution = .fill
        carTableViewTitleStackView.alignment = .firstBaseline
        carTableViewTitleStackView.addArrangedSubview(carsTitleLabel)
        carTableViewTitleStackView.addArrangedSubview(addCarButton)
        
        NSLayoutConstraint.activate([
            carTableViewTitleStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30),
            carTableViewTitleStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            carTableViewTitleStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -45),
        ])
    }
    
    
    @objc func handleAddCarButton() {
        let destVC = AddCarVC()
        destVC.uid = user?.uid
        destVC.isComingInApp = true
        let navController = UINavigationController(rootViewController: destVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
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
    
    
    private func fetchUser(with uid: String) {
        showLoadingView()
        FirestoreManager.fetchUser(uid: uid) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.headerView.set(title: user.name, detail: user.email)
                self.fetchUsersCars(with: user)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    private func fetchUsersCars(with user: User) {
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
}



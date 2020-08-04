//
//  AddCarVC.swift
//  Car Service App
//
//  Created by Murat Baykor on 4.08.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class AddCarVC: UIViewController {
    
    let tableView = UITableView()
    let titleLabel = CSATitleLabel()
    let doneButton = CSAAuthButton(title: "Done")
    let addLaterButton = CSATextButton(title: "Add Later", color: Colors.softBlue)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTitleLabel()
        configureTableView()
        
        configureDoneButton()
        configureAddLaterButton()
        
        tableView.register(AddCarCell.self, forCellReuseIdentifier: AddCarCell.reuseID)
        
        
        
        
        
    }
    
    func configureView() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = Colors.darkBlue
        view.isUserInteractionEnabled = true
        //view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleViewTap)))
    }
    
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.text = "Add Car"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 125),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50)
        ])
    }
    
    func configureTableView() {
        
        view.addSubview(tableView)
        
        tableView.backgroundColor = .clear
        tableView.separatorColor = .white
        tableView.separatorInset = .init(top: 0, left: 15, bottom: 0, right: 15)
        tableView.rowHeight = 70
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 35),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            tableView.heightAnchor.constraint(equalToConstant: 360)
        ])
    }
    
    func configureDoneButton() {
        view.addSubview(doneButton)
        
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            doneButton.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 30),
            doneButton.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -30),
            doneButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func configureAddLaterButton() {
        view.addSubview(addLaterButton)
        
        NSLayoutConstraint.activate([
            addLaterButton.bottomAnchor.constraint(equalTo: doneButton.bottomAnchor, constant: 50),
            addLaterButton.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 30),
            addLaterButton.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -30),
            addLaterButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
}

extension AddCarVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0: return AddCarCell(style: .value1, reuseIdentifier: AddCarCell.reuseID, cellType: .brand)
        case 1: return AddCarCell(style: .value1, reuseIdentifier: AddCarCell.reuseID, cellType: .model)
        case 2: return AddCarCell(style: .value1, reuseIdentifier: AddCarCell.reuseID, cellType: .color)
        case 3: return AddCarCell(style: .value1, reuseIdentifier: AddCarCell.reuseID, cellType: .plateNumber)
        case 4: return AddCarCell(style: .value1, reuseIdentifier: AddCarCell.reuseID, cellType: .usage)
        default: fatalError("error")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let destVC = CarListVC()
            navigationController?.pushViewController(destVC, animated: true)
        default: fatalError("error")
        }
    }
    
    
    
}

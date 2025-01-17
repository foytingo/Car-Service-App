//
//  ShowAppointmentsVC.swift
//  Car Service App
//
//  Created by Murat Baykor on 11.08.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class ShowAppointmentsVC: CSALoadingVC {
    
    var carUid: String?
    
    var car: Car? {
        didSet {
            guard let car = car else { return }
            headerView.set(title: car.plateNumber.uppercased(), detail: "\(car.brand) - \(car.year) - \(car.model)")
            fetchAppointment(with: car)
        }
    }
    
    
    var appointments = [Appointment]() {
        didSet {
            DispatchQueue.main.async {
                self.appointmentTableView.reloadData()
            }
        }
    }
    
    
    let headerTitleLabel = CSATitleLabel()
    let headerView = MainHeaderView()
    let appointmentTitleLabel = CSATitleLabel()
    let addAppointmentButton = CSATextButton(title: "Add new", color: Colors.softBlue)
    let appointmentTableViewTitleStackView = UIStackView()
    let appointmentTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureHeaderTitleLabel()
        configureHeaderView()
        configureCarTableViewTitleStackView()
        configureAppointmentTableView()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.appointments.removeAll()
        showLoadingView()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let carUid = carUid else { return }
        DispatchQueue.global(qos: .userInitiated).async {
            self.fetchCar(with: carUid)
        }
    }
    
    
    func configureView() {
        view.backgroundColor = Colors.darkBlue
    }
    
    
    func configureHeaderTitleLabel() {
        view.addSubview(headerTitleLabel)
        
        headerTitleLabel.text = "Car"
        
        NSLayoutConstraint.activate([
            headerTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headerTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
    
    
    func configureHeaderView() {
        view.addSubview(headerView)
 
        headerView.settingsButton.isHidden = true
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: headerTitleLabel.bottomAnchor, constant: 10),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            headerView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    
    func configureCarTableViewTitleStackView() {
        view.addSubview(appointmentTableViewTitleStackView)
        
        appointmentTitleLabel.text = "Appointments"
        addAppointmentButton.addTarget(self, action: #selector(handleAddNewButton), for: .touchUpInside)
        
        appointmentTableViewTitleStackView.translatesAutoresizingMaskIntoConstraints = false
        appointmentTableViewTitleStackView.axis = .horizontal
        appointmentTableViewTitleStackView.distribution = .fill
        appointmentTableViewTitleStackView.alignment = .firstBaseline
        appointmentTableViewTitleStackView.addArrangedSubview(appointmentTitleLabel)
        appointmentTableViewTitleStackView.addArrangedSubview(addAppointmentButton)
        
        NSLayoutConstraint.activate([
            appointmentTableViewTitleStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30),
            appointmentTableViewTitleStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            appointmentTableViewTitleStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -45),
        ])
    }
    
    
    @objc func handleAddNewButton() {
        let destVC = SetAppointmentVC()
        destVC.car = car
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    
    func configureAppointmentTableView() {
        view.addSubview(appointmentTableView)
        
        appointmentTableView.rowHeight = 100
        appointmentTableView.separatorStyle = .none
        appointmentTableView.allowsSelection = false
        appointmentTableView.backgroundColor = Colors.darkBlue
        appointmentTableView.translatesAutoresizingMaskIntoConstraints = false
        appointmentTableView.register(AppointmentCell.self, forCellReuseIdentifier: AppointmentCell.reuseID)
        appointmentTableView.delegate = self
        appointmentTableView.dataSource = self
        
        NSLayoutConstraint.activate([
            appointmentTableView.topAnchor.constraint(equalTo: appointmentTableViewTitleStackView.bottomAnchor, constant: 10),
            appointmentTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            appointmentTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            appointmentTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    
    private func fetchCar(with uid: String) {
        FirestoreManager.fetchCar(uid: uid) { [weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let car):
                self.car = car
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    private func fetchAppointment(with car: Car) {
        if car.appointments.count == 0 {
            self.dismissLoadingView()
        } else {
            for appointment in car.appointments {
                FirestoreManager.fetcAppointments(uid: appointment, car: car) { [weak self] result in
                    guard let self = self else { return }
                    self.dismissLoadingView()
                    switch result {
                    case .success(let appointment):
                        self.appointments.append(appointment)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}


extension ShowAppointmentsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppointmentCell.reuseID, for: indexPath) as! AppointmentCell
        cell.set(appointment: appointments[indexPath.row])
        cell.appointmentCellDelegate = self
        return cell
    }
    
}

extension ShowAppointmentsVC: AppointmentCellDelegate {
    func didTapActionButton(_ cell: AppointmentCell) {
        guard let appointment = cell.appointment else { return }
        guard let indexPath = appointmentTableView.indexPath(for: cell) else { return }
        presentAlertWithDeleteAction(title: "Are you sure", message: "") { action in
            self.showLoadingView()
            FirestoreManager.deleteAppointment(appointmentUid: appointment.uid.uuidString) { [weak self] result in
                guard let self = self else { return }
                self.dismissLoadingView()
                switch result {
                case .success(_):
                    self.appointments.remove(at: indexPath.row)
                case .failure(let error):
                    self.presentAlertWithOk(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
    
}

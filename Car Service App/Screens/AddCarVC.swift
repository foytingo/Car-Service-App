//
//  AddCarVC.swift
//  Car Service App
//
//  Created by Murat Baykor on 4.08.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class AddCarVC: CSALoadingVC{
    
    let titleLabel = CSATitleLabel()
    let brandSelectView = CSASelectPropertiesView(labelText: "Brand", tag: 0)
    let yearSelectView = CSASelectPropertiesView(labelText: "Year", tag: 1)
    let modelSelectView = CSASelectPropertiesView(labelText: "Model", tag: 2)
    let colorSelectView = CSASelectPropertiesView(labelText: "Color", tag: 3)
    let licenseSelectView = CSASelectPropertiesView(labelText: "Plate Number", tag: 4)
    let currentKmView = CSASelectPropertiesView(labelText: "Current Kilometer", tag: 5)
    
    let doneButton = CSAAuthButton(title: "Done")
    let addLaterButton = CSATextButton(title: "Add Later", color: Colors.softBlue)
    
    var uid: String?
    
    var brand: String? {
        didSet { brandSelectView.detailLabel.text = brand }
    }
    
    var year: String? {
        didSet{ yearSelectView.detailLabel.text = year }
    }
    
    var model: String? {
        didSet { modelSelectView.detailLabel.text = model }
    }
    
    var color: String? {
        didSet { colorSelectView.detailLabel.text = color }
    }
    
    var plateNumber: String? {
        didSet { licenseSelectView.detailLabel.text = plateNumber }
    }
    
    var currentKm: String? {
        didSet { currentKmView.detailLabel.text = currentKm }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTitleLabel()
        configureBrandSelectView()
        configureyearSelectView()
        configureModelSelectView()
        configureColorSelectView()
        configureLicenseSelectView()
        configureCurrentKmView()
        
        configureDoneButton()
        configureAddLaterButton()
        
    }
    
    func configureView() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        view.backgroundColor = Colors.darkBlue
        view.isUserInteractionEnabled = true
    }
    
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.text = "Add Car"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 125),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50)
        ])
    }
    
    func configureBrandSelectView() {
        view.addSubview(brandSelectView)
        addTapGesture(view: brandSelectView)
        NSLayoutConstraint.activate([
            brandSelectView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            brandSelectView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            brandSelectView.heightAnchor.constraint(equalToConstant: 50),
            brandSelectView.widthAnchor.constraint(equalToConstant: 325)
        ])
    }
    
    func configureyearSelectView() {
        view.addSubview(yearSelectView)
        addTapGesture(view: yearSelectView)
        NSLayoutConstraint.activate([
            yearSelectView.topAnchor.constraint(equalTo: brandSelectView.bottomAnchor, constant: 10),
            yearSelectView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            yearSelectView.heightAnchor.constraint(equalToConstant: 50),
            yearSelectView.widthAnchor.constraint(equalToConstant: 325)
        ])
    }
    
    func configureModelSelectView() {
        view.addSubview(modelSelectView)
        addTapGesture(view: modelSelectView)
        NSLayoutConstraint.activate([
            modelSelectView.topAnchor.constraint(equalTo: yearSelectView.bottomAnchor, constant: 10),
            modelSelectView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            modelSelectView.heightAnchor.constraint(equalToConstant: 50),
            modelSelectView.widthAnchor.constraint(equalToConstant: 325)
        ])
    }
    
    func configureColorSelectView() {
        view.addSubview(colorSelectView)
        addTapGesture(view: colorSelectView)
        NSLayoutConstraint.activate([
            colorSelectView.topAnchor.constraint(equalTo: modelSelectView.bottomAnchor, constant: 10),
            colorSelectView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            colorSelectView.heightAnchor.constraint(equalToConstant: 50),
            colorSelectView.widthAnchor.constraint(equalToConstant: 325)
        ])
    }
    
    func configureLicenseSelectView() {
        view.addSubview(licenseSelectView)
        addTapGesture(view: licenseSelectView)
        NSLayoutConstraint.activate([
            licenseSelectView.topAnchor.constraint(equalTo: colorSelectView.bottomAnchor, constant: 10),
            licenseSelectView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            licenseSelectView.heightAnchor.constraint(equalToConstant: 50),
            licenseSelectView.widthAnchor.constraint(equalToConstant: 325)
        ])
    }
    
    func configureCurrentKmView() {
        view.addSubview(currentKmView)
        addTapGesture(view: currentKmView)
        NSLayoutConstraint.activate([
            currentKmView.topAnchor.constraint(equalTo: licenseSelectView.bottomAnchor, constant: 10),
            currentKmView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentKmView.heightAnchor.constraint(equalToConstant: 50),
            currentKmView.widthAnchor.constraint(equalToConstant: 325)
        ])
    }
    
    
    func configureDoneButton() {
        view.addSubview(doneButton)
        
        doneButton.addTarget(self, action: #selector(doneButtonHandler), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: currentKmView.bottomAnchor, constant: 30),
            doneButton.leadingAnchor.constraint(equalTo: currentKmView.leadingAnchor, constant: 30),
            doneButton.trailingAnchor.constraint(equalTo: currentKmView.trailingAnchor, constant: -30),
            doneButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    @objc func doneButtonHandler() {
        guard let brand = brand else { return }
        guard let year = year else { return }
        guard let model = model else { return }
        guard let color = color else { return }
        guard let plateNumber = plateNumber else { return }
        guard let currentKm = currentKm else { return }
   
        let newCar = Car(uid: UUID(), brand: brand, year: year, model: model, color: color, plateNumber: plateNumber, currentKm: currentKm)
       
        guard let uid = uid else { return }
        
        showLoadingView()
        FirestoreManager.uploadCar(userUid: uid , car: newCar) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let uid):
                self.presentMainVC(with: uid)
            case .failure(let error):
                self.presentAlertWithOk(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    
    func presentMainVC(with uid: String) {
        let mainVC = MainVC()
        //mainVC.uid = uid
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
    
    
    func configureAddLaterButton() {
        view.addSubview(addLaterButton)
        
        NSLayoutConstraint.activate([
            addLaterButton.bottomAnchor.constraint(equalTo: doneButton.bottomAnchor, constant: 50),
            addLaterButton.leadingAnchor.constraint(equalTo: currentKmView.leadingAnchor, constant: 30),
            addLaterButton.trailingAnchor.constraint(equalTo: currentKmView.trailingAnchor, constant: -30),
            addLaterButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    func addTapGesture(view: CSASelectPropertiesView) {
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func handleTap(sender: UIGestureRecognizer) {
        if let view = sender.view as? CSASelectPropertiesView{
            switch view.tag {
            case 0:
                let destVC = BrandListVC()
                destVC.selectBrandDelegate = self
                navigationController?.pushViewController(destVC, animated: true)
            case 1:
                let destVC = YearListVC()
                guard brand != nil else {
                    print("select brand first")
                    return
                }
                destVC.selectYearDelegate = self
                navigationController?.pushViewController(destVC, animated: true)
            case 2:
                let destVC = ModelListVC()
                guard brand != nil else {
                    print("select brand first")
                    return
                }
                destVC.brand = brand
                destVC.selectModelDelegate = self
                navigationController?.pushViewController(destVC, animated: true)
            case 3:
                let destVC = ColorListVC()
                destVC.selectColorDelegate = self
                navigationController?.pushViewController(destVC, animated: true)
            case 4:
                presentAlertWithTextField(title: "License Plate Number", message: "", placeholder: "Enter licence plate number.") { [weak self] text in
                    guard let self = self else { return }
                    self.plateNumber = text
                    
                }
            case 5:
                presentAlertWithTextField(title: "Current Kilometer", message: "", placeholder: "Enter current km your car.") { [weak self] text in
                    guard let self = self else { return }
                    self.currentKm = text
            
                }
            default:
                print("err")
            }
            
        }
    }
    
}

extension AddCarVC: SelectBrandDelegate {
    func didSelectBrand(selectedBrand: String) {
        brand = selectedBrand
    }
}

extension AddCarVC: SelectYearDelegate {
    func didSelectYear(selectedYear: String) {
        year = selectedYear
    }
    
}

extension AddCarVC: SelectModelDelegate {
    func didSelectModel(selectedModel: String) {
        model = selectedModel
    }
}

extension AddCarVC: SelectColorDelegate {
    func didSelectColor(selectedColor: String) {
        color = selectedColor
    }
    

    
    
    
    
}


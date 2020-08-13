//
//  ModelListVC.swift
//  Car Service App
//
//  Created by Murat Baykor on 5.08.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

protocol SelectModelDelegate: class {
    func didSelectModel(selectedModel: String)
}

class ModelListVC: UITableViewController {
    
    var modelArray: [String]?
    
    var brand: String? {
        didSet {
            switch brand {
            case "Audi":
                modelArray = Arrays.audiModels
            case "Seat":
                modelArray = Arrays.seatModels
            case "Volkswagen":
                modelArray = Arrays.volkswagenModels
            case "Porsche":
                modelArray = Arrays.porscheModels
            case "Skoda":
                modelArray = Arrays.skodaModels
            default:
                modelArray = []
            }
        }
    }
    
    var modelYear: String?
    
    weak var selectModelDelegate: SelectModelDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureTableView()
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    private func configureView() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = Colors.softBlue
        navigationController?.navigationBar.tintColor = Colors.darkBlue
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        view.backgroundColor = Colors.darkBlue
        title = "Select Car Model"
    }
    
    
    private func configureTableView() {
        tableView.separatorColor = Colors.softBlue
        tableView.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ModelCell")
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = modelArray?.count else { return 0 }
        return count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ModelCell", for: indexPath)
        cell.textLabel?.text = modelArray?[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = Colors.darkBlue
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = modelArray?[indexPath.row] else { return }
        selectModelDelegate?.didSelectModel(selectedModel: model)
        navigationController?.popViewController(animated: true)
    }
    
}

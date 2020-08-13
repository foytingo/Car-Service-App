//
//  BrandListVC.swift
//  Car Service App
//
//  Created by Murat Baykor on 5.08.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

protocol SelectBrandDelegate: class {
    func didSelectBrand(selectedBrand: String)
}

class BrandListVC: UITableViewController {
    
    weak var selectBrandDelegate: SelectBrandDelegate?
    
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
        title = "Select Car Brand"
    }
    
    
    private func configureTableView() {
        tableView.separatorColor = Colors.softBlue
        tableView.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CarBrandCell")
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Arrays.carBrands.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarBrandCell", for: indexPath)
        cell.textLabel?.text = Arrays.carBrands[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = Colors.darkBlue
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectBrandDelegate?.didSelectBrand(selectedBrand: Arrays.carBrands[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
    
}

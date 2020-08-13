//
//  YearListVC.swift
//  Car Service App
//
//  Created by Murat Baykor on 5.08.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

protocol SelectYearDelegate: class {
    func didSelectYear(selectedYear: String)
}

class YearListVC: UITableViewController {

    weak var selectYearDelegate: SelectYearDelegate?
    
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
        title = "Select Car Model Year"
    }
    
    
    private func configureTableView() {
        tableView.separatorColor = Colors.softBlue
        tableView.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ModelYearCell")
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Arrays.modelYears.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ModelYearCell", for: indexPath)
        cell.textLabel?.text = Arrays.modelYears[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = Colors.darkBlue
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectYearDelegate?.didSelectYear(selectedYear: Arrays.modelYears[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}


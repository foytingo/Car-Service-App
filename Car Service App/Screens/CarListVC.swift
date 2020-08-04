//
//  CarListVC.swift
//  Car Service App
//
//  Created by Murat Baykor on 4.08.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class CarListVC: UIViewController {

    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = Colors.softBlue
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = Colors.darkBlue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        title = "Brand List"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .white
        tableView.isScrollEnabled = false
        tableView.backgroundColor = Colors.darkBlue
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CarCell")
    }
}

extension CarListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Arrays.carBrands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell", for: indexPath)
        cell.textLabel?.text = Arrays.carBrands[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = Colors.darkBlue
        cell.tintColor = .white
        let image = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
        let disclosure  = UIImageView(frame:CGRect(x:0, y:0, width:(image?.size.width)!, height:(image?.size.height)!));
        disclosure.image = image
        cell.accessoryView = disclosure
        return cell
    }
    
    
}

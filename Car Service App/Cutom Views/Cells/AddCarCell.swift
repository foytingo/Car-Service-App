//
//  AddCarCell.swift
//  Car Service App
//
//  Created by Murat Baykor on 4.08.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

enum CellType {
    case brand, model, color, usage, plateNumber
}

class AddCarCell: UITableViewCell {

    static let reuseID = "AddCarCell"
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    }
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, cellType: CellType) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure(cellType: cellType)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(cellType: CellType) {
        accessoryType = .disclosureIndicator
        backgroundColor = .clear
        textLabel?.textColor = .white
        detailTextLabel?.textColor = Colors.softBlue
        tintColor = .white
        selectionStyle = .none
        
        let image = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
        let disclosure  = UIImageView(frame:CGRect(x:0, y:0, width:(image?.size.width)!, height:(image?.size.height)!));
        disclosure.image = image
        accessoryView = disclosure
        
        
        switch cellType {
        case .brand:
            textLabel?.text = "Brand"
        case .model:
            textLabel?.text = "Model"
        case .color:
            textLabel?.text = "Color"
        case .usage:
            textLabel?.text = "Curent Usage"
        case .plateNumber:
            textLabel?.text = "License Plate Number"
        }
    }
    

}

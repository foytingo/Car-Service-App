//
//  UIViewController+Ext.swift
//  Car Service App
//
//  Created by Murat Baykor on 30.07.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlertWithOk(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    func presentAlertWithOkAction(title: String, message: String, handler: ((UIAlertAction) -> Void)?) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: handler))
        present(ac, animated: true)
    }
    
    func presentAlertWithTextField(title: String, message: String, placeholder: String, completion:((String) -> Void)?) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        ac.addTextField { (textfield) in
            textfield.placeholder = placeholder
        }

        ac.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak ac] (_) in
            guard let ac = ac else { return }
            let textfield = ac.textFields![0]
            if textfield.text == ""{
                completion!("Not entered")
            } else {
               completion!(textfield.text!)
            }
            
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    
}


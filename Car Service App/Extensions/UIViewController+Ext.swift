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
}

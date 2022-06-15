//
//  UIViewController+Allerts.swift
//  24_vcontactsFetch
//
//  Created by Alex Fount on 9.06.22.
//

import UIKit

extension UIViewController {
    
    func showErrorAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

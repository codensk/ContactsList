//
//  UIViewController+showAlert.swift
//  ContactsList
//
//  Created by SERGEY VOROBEV on 09.06.2021.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel)
        
        alert.addAction(okButton)
        
        // hide keyboard if visible
        view.endEditing(true)
        
        present(alert, animated: true)
    }
}

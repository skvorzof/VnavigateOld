//
//  UIAlertController + Extension.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 22.12.2022.
//

import UIKit

extension UIViewController {
    func showAlert(with title: String, and message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)

        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)

        navigationController?.present(alertController, animated: true)
    }
}

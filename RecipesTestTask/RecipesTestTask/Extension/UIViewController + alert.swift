//
//  UIViewController + alert.swift
//  RecipesTestTask
//
//  Created by Vitaliy Halai on 5.11.23.
//

import UIKit

extension UIViewController {
    func showInfoAlert(
        withTitle title: String,
        withMessage message: String
    ) {
        let alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
}

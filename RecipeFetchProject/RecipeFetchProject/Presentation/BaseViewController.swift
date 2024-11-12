//
//  BaseViewController.swift
//  RecipeFetchProject
//
//  Created by Ahmet on 11.11.2024.
//

import UIKit

/// A base view controller class providing common configuration for navigation bar appearance
/// and utility methods for presenting error messages.
class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBarAppearance()
    }
    
    /// Configures the appearance of the navigation bar
    private func configureNavigationBarAppearance() {
        if let navigationController = navigationController {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .blue // Background color
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // Title text color

            navigationController.navigationBar.standardAppearance = appearance
            navigationController.navigationBar.scrollEdgeAppearance = appearance
        }
    }
    
    /// Displays a popup alert with the provided error message.
    /// - Parameters:
    ///   - title: The title of the alert (default is "Error").
    ///   - message: The error message to display.
    ///   - completion: An optional completion handler that is called when the alert is dismissed.
    func showErrorPopup(title: String = ErrorMessages.errorTitle, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: ErrorMessages.errorButtonTitle, style: .default) { _ in
            completion?()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

}

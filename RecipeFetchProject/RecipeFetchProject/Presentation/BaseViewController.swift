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

}

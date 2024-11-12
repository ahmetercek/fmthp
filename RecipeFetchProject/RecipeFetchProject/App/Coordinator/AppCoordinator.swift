//
//  AppCoordinator.swift
//  RecipeFetchProject
//
//  Created by Ahmet on 11.11.2024.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    
    override func start() {
        // Create and present the HomeViewController
        let homeViewController = HomeViewController()
        navigationController.pushViewController(homeViewController, animated: false)
    }
}

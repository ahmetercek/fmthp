//
//  BaseCoordinator.swift
//  RecipeFetchProject
//
//  Created by Ahmet on 11.11.2024.
//

import UIKit

/// Coordinators handle the navigation flow within the app.
protocol Coordinator {
    /// The navigation controller that the coordinator manages.
    var navigationController: UINavigationController { get set }
    
    /// Starts the coordinator by setting up its initial view controller(s).
    func start()
}

/// A base implementation of the `Coordinator` protocol.
/// Provides a starting point for other coordinators to inherit from.
class BaseCoordinator: Coordinator {
    /// The navigation controller that this coordinator manages.
    var navigationController: UINavigationController

    /// Initializes a new instance of `BaseCoordinator` with the specified navigation controller.
    /// - Parameter navigationController: The navigation controller to be used by the coordinator.
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    /// Starts the coordinator's navigation flow.
    /// This method is intended to be overridden by subclasses to provide specific behavior.
    func start() {
        // Subclasses will override this to define their own navigation flow
    }
}

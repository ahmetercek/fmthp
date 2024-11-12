//
//  HomeViewController.swift
//  RecipeFetchProject
//
//  Created by Ahmet on 11.11.2024.
//

import UIKit

class HomeViewController: BaseViewController {
    
    // MARK: - Properties
    private var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        title = "Home"
        
        configureViewModel()
        fetchRecipes()
    }
    
    private func configureViewModel() {
        viewModel = HomeViewModel(recipeService: RecipeService())
    }
    
    private func fetchRecipes() {
        Task {
            do {
                try await viewModel.fetchRecipes() // Call the async function
                let recipes = viewModel.recipes
                print(recipes)
            } catch {
                // Handle error
            }
        }
    }
    
}

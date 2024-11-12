//
//  HomeViewModel.swift
//  RecipeFetchProject
//
//  Created by Ahmet on 11.11.2024.
//

import Foundation

class HomeViewModel {
    
    // MARK: - Properties
    
    /// Service used to fetch recipes from a data source.
    private let recipeService: RecipeServiceProtocol
    
    /// Stored recipes fetched from the service.
    private(set) var recipes: [Recipe] = []
    
    /// Stores error messages for the view controller.
    var errorMessage: String?
    
    // MARK: - Initialization
    
    /// Initializes a new instance of `HomeViewModel` with the specified recipe service.
    /// - Parameter recipeService: The service used to fetch recipes.
    init(recipeService: RecipeServiceProtocol) {
        self.recipeService = recipeService
    }
    
    // MARK: - Methods
    
    /// Fetches recipes asynchronously.
    func fetchRecipes() async throws {
        let result = try await recipeService.fetchRecipes()
        recipes = result
    }
    
    /// Returns the number of recipes.
    /// - Returns: The number of recipes in the list.
    func numberOfRecipes() -> Int {
        return recipes.count
    }
    
    /// Checks if the recipe list is empty.
    /// - Returns: `true` if the recipe list is empty, otherwise `false`.
    func isRecipeListEmpty() -> Bool {
        return recipes.isEmpty
    }
    
    /// Retrieves a recipe at the specified index.
    /// - Parameter index: The index of the recipe to retrieve.
    /// - Returns: The recipe at the specified index, or `nil` if the index is out of bounds.
    func getRecipe(at index: Int) -> Recipe? {
        guard index >= 0 && index < recipes.count else { return nil }
        return recipes[index]
    }
}

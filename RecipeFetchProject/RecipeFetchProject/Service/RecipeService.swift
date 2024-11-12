//
//  RecipeService.swift
//  RecipeFetchProject
//
//  Created by Ahmet on 11.11.2024.
//

import Foundation

/// A protocol defining the requirements for a service that fetches recipes.
protocol RecipeServiceProtocol {
    /// Fetches recipes from a data source using `async/await`.
    /// - Returns: An array of recipes fetched from the data source.
    /// - Throws: A `NetworkError` if the request fails.
    func fetchRecipes() async throws -> [Recipe]
    
}

/// A concrete implementation of `RecipeServiceProtocol` that fetches recipes using a network manager.
class RecipeService: RecipeServiceProtocol {
    
    /// The network manager responsible for making API requests.
    private let networkManager: NetworkManager
    
    /// Initializes a new instance of `RecipeService` with a given network manager.
    /// - Parameter networkManager: The network manager to be used for making API requests. Defaults to the shared instance.
    init(networkManager: NetworkManager = .shared) {
        self.networkManager = networkManager
    }
    
    /// Fetches recipes from a predefined API endpoint.
    /// - Returns: An array of `Recipe` objects fetched from the API.
    /// - Throws: A `NetworkError` if the request fails.
    func fetchRecipes() async throws -> [Recipe] {
        // Define the API endpoint for fetching recipes
        let endpoint = API.Endpoints.getAllRecipes
        
        // Use the network manager to perform a request with async/await
        let response: RecipeResponse = try await networkManager.request(endpoint: "\(endpoint)")
        return response.recipes
    }
}

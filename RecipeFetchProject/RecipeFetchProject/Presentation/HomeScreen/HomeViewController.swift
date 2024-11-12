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
    
    // MARK: - UI
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Home"
        
        setupTableView()
        configureViewModel()
        fetchRecipes()
    }
    
    /// Sets up the properties and behavior of the table view
    private func setupTableView() {
        // Set the data source and delegate for the table view
        tableView.dataSource = self
        tableView.delegate = self
        
        // Register a table view cell with a reuse identifier
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RecipeTableViewCell")
    }
    
    private func configureViewModel() {
        viewModel = HomeViewModel(recipeService: RecipeService())
    }
    
    /// Initiates the fetching of recipes in an asynchronous task.
    private func fetchRecipes() {
        // Use a task to perform asynchronous work without blocking the main thread
        Task {
            await fetchAndHandleRecipes()
        }
    }
    
    /// Fetches and handles the display of recipes asynchronously.
    /// This method interacts with the view model to fetch recipes and updates the UI accordingly.
    private func fetchAndHandleRecipes() async {
        do {
            // Try to fetch recipes asynchronously using the view model
            try await viewModel.fetchRecipes()
            // Update the UI if fetching is successful
            updateUI()
        } catch {
            // Show an error message popup if fetching fails
        }
    }
    
    /// Updates the user interface based on the current state of the recipe list.
    func updateUI() {
        // Reload the table view to reflect the updated data state
        tableView.reloadData()
    }
    
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    /// Returns the number of rows (recipes) to display in the table view.
    /// - Parameters:
    ///   - tableView: The table view requesting this information.
    ///   - section: The section index (in this case, only one section is used).
    /// - Returns: The number of rows in the specified section.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRecipes()
    }

    /// Provides the cell to display at the specified index path.
    /// - Parameters:
    ///   - tableView: The table view requesting the cell.
    ///   - indexPath: The index path specifying the location of the cell.
    /// - Returns: A configured `UITableViewCell` to display.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue a reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath)

        let recipe = viewModel.getRecipe(at: indexPath.row)
        cell.textLabel?.text = recipe?.name

        return cell
    }
}


// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
}

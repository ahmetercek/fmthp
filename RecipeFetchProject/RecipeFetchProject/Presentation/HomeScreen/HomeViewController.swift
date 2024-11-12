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
    private var refreshControl = UIRefreshControl()
    
    // MARK: - UI
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    // MARK: - Lifecycle
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
        
        // Register a custom table view cell with a reuse identifier
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: "RecipeTableViewCell")
        
        // Configure automatic dimension for row heights and provide an estimated row height for better performance
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 96
        
        // Add a pull-to-refresh control to the table view
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
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
    /// If an error occurs during fetching, it displays an error popup with the appropriate message.
    private func fetchAndHandleRecipes() async {
        do {
            // Try to fetch recipes asynchronously using the view model
            try await viewModel.fetchRecipes()
            // Update the UI if fetching is successful
            updateUI()
        } catch {
            // Show an error message popup if fetching fails
            showErrorPopup(message: error.localizedDescription)
        }
        // End the refresh control animation regardless of success or failure
        refreshControl.endRefreshing()
    }
    
    /// Updates the user interface based on the current state of the recipe list.
    /// If the recipe list is empty, it shows a "No Data" label and hides the table view.
    /// Otherwise, it hides the "No Data" label and reloads the table view data.
    func updateUI() {
        // Check if the recipe list is empty
        let isEmpty = viewModel.isRecipeListEmpty()
        
        // Show or hide the "No Data" label based on the data state
        noDataLabel.isHidden = !isEmpty
        
        // Reload the table view to reflect the updated data state
        tableView.reloadData()
    }
    
    // MARK: - Actions

    /// Handles the pull-to-refresh action triggered by the user.
    @objc private func handleRefresh() {
        // Re-fetch recipes when user pulls to refresh
        fetchRecipes()
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
        // Dequeue a reusable cell of type `CustomTableViewCell`
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }

        // Fetch the recipe from the view model and configure the cell if available
        if let recipe = viewModel.getRecipe(at: indexPath.row) {
            cell.configure(with: recipe)
        }

        return cell
    }
}


// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
}

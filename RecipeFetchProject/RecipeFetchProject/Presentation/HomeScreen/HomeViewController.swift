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
        
    }
    
    private func configureViewModel() {
        viewModel = HomeViewModel()
    }
}

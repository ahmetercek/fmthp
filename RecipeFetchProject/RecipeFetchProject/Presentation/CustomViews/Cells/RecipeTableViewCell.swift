//
//  RecipeTableViewCell.swift
//  RecipeFetchProject
//
//  Created by Ahmet on 11.11.2024.
//

import UIKit
import Kingfisher

/// Custom table view cell for displaying recipe details, including a photo, cuisine, and name.
class RecipeTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    /// Label to display the cuisine of the recipe.
    private let cuisineLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    /// Label to display the name of the recipe.
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    /// Image view to display the recipe's photo.
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    // MARK: - Initializer
    
    /// Initializes a table view cell with a style and reuse identifier.
    /// - Parameters:
    ///   - style: The cell style.
    ///   - reuseIdentifier: A string used to identify the cell object if it is to be reused for drawing multiple rows of a table view.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    /// Required initializer with NSCoder, used when initializing from a storyboard or nib file.
    /// - Parameter coder: An unarchiver object.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    // MARK: - Setup Views
    
    /// Sets up the cell's views and layout constraints.
    private func setupViews() {
        contentView.addSubview(photoImageView)
        contentView.addSubview(cuisineLabel)
        contentView.addSubview(nameLabel)

        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        cuisineLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        // Layout constraints for the image view
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            photoImageView.widthAnchor.constraint(equalToConstant: 80)
        ])

        // Set the height constraint for the image view with a lower priority
        let heightConstraint = photoImageView.heightAnchor.constraint(equalToConstant: 80)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true

        // Layout constraints for the labels
        NSLayoutConstraint.activate([
            cuisineLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 16),
            cuisineLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            cuisineLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            nameLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: cuisineLabel.bottomAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    
    // MARK: - Configure Cell
    
    /// Configures the cell with a `Recipe` object.
    /// - Parameter recipe: The `Recipe` object containing data to be displayed in the cell.
    func configure(with recipe: Recipe) {
        nameLabel.text = recipe.name
        cuisineLabel.text = recipe.cuisine
        
        // Use Kingfisher to load and cache the image asynchronously
        if let url = URL(string: recipe.photoUrlSmall ?? "") {
            photoImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholderImage"))
        }
    }
}

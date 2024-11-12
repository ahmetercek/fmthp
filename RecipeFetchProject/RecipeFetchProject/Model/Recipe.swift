//
//  Recipe.swift
//  RecipeFetchProject
//
//  Created by Ahmet on 11.11.2024.
//

import Foundation

struct Recipe: Decodable {
    let cuisine: String
    let name: String
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let uuid: String
    let sourceUrl: String?
    let youtubeUrl: String?

    // Mapping JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case uuid
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }
}

struct RecipeResponse: Decodable {
    let recipes: [Recipe]
}

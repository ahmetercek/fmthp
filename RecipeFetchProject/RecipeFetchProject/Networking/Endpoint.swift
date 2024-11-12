//
//  Endpoint.swift
//  RecipeFetchProject
//
//  Created by Ahmet on 11.11.2024.
//

struct API {
    static let baseURL = "https://d3jbb8n5wk0qxi.cloudfront.net"

    struct Endpoints {
        static let getAllRecipes = "/recipes.json"
        static let getMalformedRecipes = "/recipes-malformed.json"
        static let getEmptyData = "/recipes-empty.json"
    }
}

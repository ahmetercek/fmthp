//
//  NetworkLayerTest.swift
//  RecipeFetchProject
//
//  Created by Ahmet on 12.11.2024.
//

import XCTest
@testable import RecipeFetchProject

final class NetworkLayerTest: XCTestCase {
    var networkManager: NetworkManager!
    var mockSession: URLSessionMock!

    /// Sets up the testing environment before each test method is invoked.
    override func setUp() {
        super.setUp()
        mockSession = URLSessionMock()
        networkManager = NetworkManager(session: mockSession!)
    }

    /// Cleans up the testing environment after each test method is invoked.
    override func tearDown() {
        networkManager = nil
        mockSession = nil
        super.tearDown()
    }
    
    // Helper function to create mock data
    func createMockData(jsonString: String) -> Data {
        return jsonString.data(using: .utf8)!
    }
    
    // Helper function to configure the mock session
    func configureMockSession(with jsonData: Data, statusCode: Int = 200) {
        mockSession.data = jsonData
        mockSession.response = HTTPURLResponse(url: URL(string: API.baseURL)!,
                                                   statusCode: statusCode,
                                                   httpVersion: nil,
                                                   headerFields: nil)
    }
    
    // Test case for a successful network fetch
    func testRequest_SuccessfulResponse() async throws {
        let jsonData = """
        {
                "recipes": [
                    {
                        "cuisine": "Malaysian",
                        "name": "Apam Balik",
                        "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                        "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                        "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                        "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                        "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
                    },
                    {
                        "cuisine": "British",
                        "name": "Apple & Blackberry Crumble",
                        "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
                        "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
                        "source_url": "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
                        "uuid": "599344f4-3c5c-4cca-b914-2210e3b3312f",
                        "youtube_url": "https://www.youtube.com/watch?v=4vhcOwVBDO4"
                    }
            ]
        }
        """.data(using: .utf8)!
        configureMockSession(with: jsonData)

        let result: RecipeResponse = try await networkManager.request(endpoint: API.Endpoints.getAllRecipes, method: .get)
        XCTAssertEqual(result.recipes.count, 2)
        XCTAssertEqual(result.recipes[0].name, "Apam Balik")
        XCTAssertEqual(result.recipes[0].cuisine, "Malaysian")
        XCTAssertEqual(result.recipes[1].name, "Apple & Blackberry Crumble")
        XCTAssertEqual(result.recipes[1].cuisine, "British")
    }

    // Test case for a successful network fetch
    func testRequest_FailResponse() async throws {
        let jsonData = """
        {
                "recipes": [
                    {
                        "cuisine": "Malaysian",
                        "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                        "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                        "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                        "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                        "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
                    },
                    {
                        "cuisine": "British",
                        "name": "Apple & Blackberry Crumble",
                        "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
                        "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
                        "source_url": "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
                        "uuid": "599344f4-3c5c-4cca-b914-2210e3b3312f",
                        "youtube_url": "https://www.youtube.com/watch?v=4vhcOwVBDO4"
                    }
            ]
        }
        """.data(using: .utf8)!
        configureMockSession(with: jsonData)

        do {
            // Attempt to fetch data using the network manager
            let result: RecipeResponse = try await networkManager.request(endpoint: API.Endpoints.getMalformedRecipes, method: .get)
            XCTFail("Expected failure, but got success")
        } catch {
            // Handle errors thrown during the request
            if let networkError = error as? NetworkError {
                // Specific handling for NetworkError cases
                XCTAssertEqual(networkError, NetworkError.decodingError)
            } else {
                // General error handling
                print("An unexpected error occurred: \(error.localizedDescription)")
            }
        }
    }
    
    
}

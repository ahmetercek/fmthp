//
//  NetworkManager.swift
//  RecipeFetchProject
//
//  Created by Ahmet on 11.11.2024.
//

import Foundation

// Enum to define HTTP methods
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

// Enum to define possible network errors
enum NetworkError: Error, LocalizedError, Equatable {
    case invalidURL
    case decodingError
    case serverError(statusCode: Int)
    case custom(message: String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .decodingError:
            return ErrorMessages.dataMalformed
        case .serverError(let statusCode):
            return "Server returned an error with status code \(statusCode)."
        case .custom(let message):
            return message
        }
    }
}

// NetworkManager class for handling network requests
class NetworkManager {

    // Singleton instance (optional, based on your needs)
    static let shared = NetworkManager()
    private let session: URLSession

    // Allow dependency injection for URLSession (defaulting to .shared for normal use)
    init(session: URLSession = .shared) {
        self.session = session
    }

    // Generic request method
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil
    ) async throws -> T {
        // Ensure the URL is valid
        guard let url = URL(string: "\(API.baseURL)\(endpoint)") else {
            throw NetworkError.invalidURL
        }

        // Create a URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        // Set headers
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        // Set parameters for POST, PUT requests
        if let parameters = parameters, method == .post || method == .put {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        // Perform the network request using async/await
        let (data, response) = try await session.data(for: request)
        
        // Validate response
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
        
        // Decode the data
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingError
        }
    }
}

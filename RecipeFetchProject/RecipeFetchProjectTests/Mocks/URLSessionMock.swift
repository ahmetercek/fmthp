//
//  URLSessionMock.swift
//  RecipeFetchProject
//
//  Created by Ahmet on 11.11.2024.
//

// URLSessionMock.swift
import Foundation
@testable import RecipeFetchProject

class URLSessionMock: NetworkSession {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }
        guard let data = data, let response = response else {
            throw NetworkError.custom(message: "No data or response")
        }
        return (data, response)
    }
}

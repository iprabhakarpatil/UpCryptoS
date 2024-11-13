//
//  MockNetworking.swift
//  UpCryptosTests
//
//  Created by Prabhakar Patil on 14/11/24.
//

import Foundation

final class MockNetworkService: NetworkServiceProtocol {
    
    var mockData: Data?
    var mockError: Error?
    
    func fetchData<T>(url: URL) async throws -> T where T : Decodable {
        if let error = mockError {
            throw error
        }
        guard let data = mockData else {
            throw URLError(.unknown)
        }
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}

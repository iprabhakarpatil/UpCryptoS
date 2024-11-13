//
//  NetworkManager.swift
//  UpCryptos
//
//  Created by Prabhakar Patil on 13/11/24.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(url: URL) async throws -> T
}


final class NetworkService: NetworkServiceProtocol {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    /// Fetch the data for the url passed
    /// - Parameter url: URL used  as declared in  APIEndpoints
    /// - Returns: T - Model conforming to Decodable
    func fetchData<T: Decodable>(url: URL) async throws -> T {
        let (data, response) = try await session.data(from: url)
        
        // Check valid HTTP response
        guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        // Decode the response data
        let decoder = JSONDecoder()
        do {
            let decodedResponse = try decoder.decode(T.self, from: data)
            return decodedResponse
            
        } catch {
            throw URLError(.cannotParseResponse)
        }
    }
}

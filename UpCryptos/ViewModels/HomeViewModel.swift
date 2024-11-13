//
//  HomeViewModel.swift
//  UpCryptos
//
//  Created by Prabhakar Patil on 13/11/24.
//

import Foundation

final class HomeViewModel{
    
    private let networkService: NetworkServiceProtocol
    var currencies: [CurrencyModel]?
    
    var filteredItems: [CurrencyModel] = []
    
    /// init with Dependency Injection of networking layer
    /// - Parameter networkService: NetworkServiceProtocol
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    /// Fetch the currencies for the table view data
    /// - Parameter api: APIEndpoints
    /// - Returns: [CurrencyModel]?
    func fetchCurrencies(from api: APIEndpoints) async throws -> [CurrencyModel]? {
        
        currencies = try await networkService.fetchData(url: api.url)
        filteredItems = currencies ?? []
        return filteredItems
    }
    
    
    /// Filter the currency based on the search text
    /// - Parameter searchText: String
    func filterItems(for searchText: String) {
        if searchText.isEmpty {
            filteredItems = currencies ?? []
        } else {
            filteredItems = currencies?.filter { $0.name.lowercased().contains(searchText.lowercased()) } ?? []
        }
    }
}


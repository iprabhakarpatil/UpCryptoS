//
//  UpCryptosTests.swift
//  UpCryptosTests
//
//  Created by Prabhakar Patil on 12/11/24.
//

import XCTest
@testable import UpCryptos

final class UserViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        viewModel = HomeViewModel(networkService: mockNetworkService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    func testFetchUserData_Success() async throws {
        // Given
        let mockCurrencies = [
            CurrencyModel(name: "Test1", symbol: "TST1", isNew: true, isActive: true, type: "token"),
            CurrencyModel(name: "Test2", symbol: "TST2", isNew: false, isActive: false, type: "token"),
            CurrencyModel(name: "Test3", symbol: "TST3", isNew: true, isActive: true, type: "coin")
        ]
        let currencyData = try JSONEncoder().encode(mockCurrencies)
        mockNetworkService.mockData = currencyData
        
        // When
        do {
            let result = try await viewModel.fetchCurrencies(from: .currencies)
            
            // Then
            XCTAssertEqual(result?.count, 3, "The number of currencies should be 3")
            XCTAssertEqual(viewModel.filteredItems.count, 3, "Filtered items should have 3 currencies after fetching data")
        } catch {
            XCTFail("Fetching user data should not fail with error: \(error)")
        }
    }

    func testFetchUserData_Failure() async {
        // Given
        let mockError = NSError(domain: "TestError", code: 1001, userInfo: nil)
        mockNetworkService.mockError = mockError
        
        // When
        do {
            _ = try await viewModel.fetchCurrencies(from: .currencies)
            XCTFail("Fetching user data should throw an error")
        } catch {
            // Then
            XCTAssertEqual((error as NSError).code, 1001, "Expected error code 1001")
        }
    }
    
    func testFilterItems() {
        // Given
        let mockCurrencies = [
            CurrencyModel(name: "Bitcoin", symbol: "BTC", isNew: false, isActive: true, type: "token"),
            CurrencyModel(name: "Ethereum", symbol: "ETH", isNew: true, isActive: true, type: "coin"),
            CurrencyModel(name: "Cardano", symbol: "CDN", isNew: false, isActive: true, type: "coin")
        ]
        viewModel.currencies = mockCurrencies
        
        // When
        viewModel.filterItems(for: "Bit")
        
        // Then
        XCTAssertEqual(viewModel.filteredItems.count, 1, "There should be only 1 currency that matches the search text 'Bit'")
        XCTAssertEqual(viewModel.filteredItems.first?.name, "Bitcoin", "The filtered item should be 'Bitcoin'")
        
        // When: Filter with an empty string
        viewModel.filterItems(for: "")
        
        // Then: It should return all currencies
        XCTAssertEqual(viewModel.filteredItems.count, 3, "There should be 3 currencies when no search text is entered")
    }
    

}

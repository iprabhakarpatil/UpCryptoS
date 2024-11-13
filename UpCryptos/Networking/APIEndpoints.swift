//
//  APIEndpoints.swift
//  UpCryptos
//
//  Created by Prabhakar Patil on 13/11/24.
//

import Foundation

public enum APIEndpoints: String{
    
    case currencies = "https://37656be98b8f42ae8348e4da3ee3193f.api.mockbin.io/"
}


// MARK: - Endpoints
extension APIEndpoints{
    
    var url: URL{
        switch self {
        case .currencies:
            return URL(string: self.rawValue)!
        }
    }
}

//
//  CurrencyModel.swift
//  UpCryptos
//
//  Created by Prabhakar Patil on 13/11/24.
//

import Foundation

struct CurrencyModel: Codable{
    
    let name: String
    let symbol: String
    let isNew: Bool
    let isActive: Bool
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case symbol
        case isNew = "is_new"
        case isActive = "is_active"
        case type
    }
    
}

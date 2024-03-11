//
//  UserDefaultStorage.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/31.
//

import Foundation

final class ProductUserDefaultStorage {
    
    private let recentsProductResponse = "recentsTemplateQueriesKey"
    private var userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    public func fetchTemplate() -> ProductsResponse? {
        if let queriesData = userDefaults.object(forKey: recentsProductResponse) as? Data {
            if let templateResponse = try? JSONDecoder().decode(ProductsResponseDTO.self, from: queriesData) {
                return templateResponse.toDomain()
            }else{
                return nil
            }
        }else {
            return nil
        }
    }

    public func saveTemplate(productResponseDTO: ProductsResponseDTO, complation: @escaping (Bool) -> Void) {
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(productResponseDTO) {
            userDefaults.set(encoded, forKey: recentsProductResponse)
            complation(true)
        }else {
            complation(false)
        }
    }
    
}

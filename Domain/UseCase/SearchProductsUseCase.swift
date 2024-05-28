//
//  SearchProductsUseCase.swift
//  CleanArchitectureExample
//
//  Created by Mehedi on 27/5/24.
//

import Foundation

protocol SearchProductsUseCaseProtocol {
    func execute(
        requestValue: SearchProductsUseCaseRquestValue,
        cached: @escaping (ProductResponse?) -> Void,
        completion: @escaping (Result<ProductResponse?, DataTransferError>) -> Void
    ) -> Cancellable?
    
}

struct SearchProductsUseCaseRquestValue {
    let query: ProductQuery
    let limit: Int
    let skip: Int
}

class SearchProductsUseCase {
    
    private let productsRepositoryProtocol: FetchProductsRepositoryProtocol
    private let productsResponseCoreDataManager: ProductsResponseCoreDataManagerProtocol
    
    init(
        productsRepositoryProtocol: FetchProductsRepositoryProtocol,
        productsResponseCoreDataManager: ProductsResponseCoreDataManagerProtocol
    ) {
        self.productsRepositoryProtocol = productsRepositoryProtocol
        self.productsResponseCoreDataManager = productsResponseCoreDataManager
    }
}

//MARK: Fetch Products UseCase
extension SearchProductsUseCase: SearchProductsUseCaseProtocol {
    
    func execute(requestValue: SearchProductsUseCaseRquestValue, cached: @escaping (ProductResponse?) -> Void, completion: @escaping (Result<ProductResponse?, DataTransferError>) -> Void) -> Cancellable? {
        
        return self.productsRepositoryProtocol.fetchQuery(productsQuery: requestValue.query, limit: requestValue.limit, skip: requestValue.skip, cached: cached, completion: { result in
            
            if case .success = result {
                completion(result)
            }
            
        })
    }
    
}

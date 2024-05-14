//
//  GetProductsUseCase.swift
//  APIDemo
//
//  Created by M M Mehedi Hasan on 2023/08/05.
//

import Foundation

protocol FetchProductsUseCaseProtocol {
    func execute(
        requestValue: GetProductsUseCaseRquestValue,
        cached: @escaping (ProductResponse?) -> Void,
        completion: @escaping (Result<ProductResponse?, DataTransferError>) -> Void
    ) -> Cancellable?
    
}

class FetchProductsUseCase {
    
    private let productsRepositoryProtocol: ProductsRepositoryProtocol
    private let productsResponseCoreDataManager: ProductsResponseCoreDataManagerProtocol
    
    init(
        productsRepositoryProtocol: ProductsRepositoryProtocol,
        productsResponseCoreDataManager: ProductsResponseCoreDataManagerProtocol
    ) {
        self.productsRepositoryProtocol = productsRepositoryProtocol
        self.productsResponseCoreDataManager = productsResponseCoreDataManager
    }
}

//MARK: Fetch Products UseCase
extension FetchProductsUseCase: FetchProductsUseCaseProtocol {
    
    func execute(requestValue: GetProductsUseCaseRquestValue, cached: @escaping (ProductResponse?) -> Void, completion: @escaping (Result<ProductResponse?, DataTransferError>) -> Void) -> Cancellable? {
        
        //let productsQuery = ProductQuery(query: requestValue.query.query)
        
        return self.productsRepositoryProtocol.fetchQuery(productsQuery: requestValue.query, limit: requestValue.limit, skip: requestValue.skip, cached: cached, completion: { result in
            
            if case .success = result {
                completion(result)
            }
            
        })
        
    }
    
}

struct GetProductsUseCaseRquestValue {
    let query: ProductQuery
    let limit: Int
    let skip: Int
}

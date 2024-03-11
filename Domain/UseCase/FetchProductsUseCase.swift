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
        cached: @escaping (ProductResponse) -> Void,
        completion: @escaping (Result<ProductResponse, DataTransferError>) -> Void
    ) -> Cancellable?
    
}

class FetchProductsUseCase {
    
    private let productsRepositoryProtocol: ProductsRepositoryProtocol
    private let productsQueriesRepository: ProductsQueriesRepositoryProtocol
    
    init(
        productsRepositoryProtocol: ProductsRepositoryProtocol,
        productsQueriesRepository: ProductsQueriesRepositoryProtocol
    ) {
        self.productsRepositoryProtocol = productsRepositoryProtocol
        self.productsQueriesRepository = productsQueriesRepository
    }
}

//MARK: Fetch Products UseCase
extension FetchProductsUseCase: FetchProductsUseCaseProtocol {
    
    func execute(requestValue: GetProductsUseCaseRquestValue, cached: @escaping (ProductResponse) -> Void, completion: @escaping (Result<ProductResponse, DataTransferError>) -> Void) -> Cancellable? {
        
        let productsQuery = ProductQuery(query: requestValue.query.query)
        
        return self.productsRepositoryProtocol.fetchQuery(productsQuery: requestValue.query, page: requestValue.page, cached: cached, completion: { result in
            
            if case .success = result {
                self.productsQueriesRepository.saveRecentQuery(query: requestValue.query) { _ in }
            }

            completion(result)
            
        })
        
    }
    
}

struct GetProductsUseCaseRquestValue {
    let query: ProductQuery
    let page: Int
}

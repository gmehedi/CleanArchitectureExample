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
        cached: @escaping ([ProductItem]) -> Void,
        completion: @escaping (Result<ProductResponse, DataTransferError>) -> Void
    ) -> Cancellable?
    
}

class FetchProductsUseCase {
    
    private let productsRepositoryProtocol: ProductsRepositoryProtocol
    
    init(
        productsRepositoryProtocol: ProductsRepositoryProtocol
    ) {
        self.productsRepositoryProtocol = productsRepositoryProtocol
    }
}

//MARK: Fetch Products UseCase
extension FetchProductsUseCase: FetchProductsUseCaseProtocol {
    
    func execute(requestValue: GetProductsUseCaseRquestValue, cached: @escaping ([ProductItem]) -> Void, completion: @escaping (Result<ProductResponse, DataTransferError>) -> Void) -> Cancellable? {
        
        let productsQuery = ProductsQuery(query: requestValue.query.query, page: requestValue.query.page)
        
        return self.productsRepositoryProtocol.fetchQuery(productsQuery: productsQuery, cached: { products in
            
             cached(products)
            
        }, completion: { result in
            
            completion(result)
            
        })
    }
    
}

struct GetProductsUseCaseRquestValue {
    let query: ProductsQuery
}

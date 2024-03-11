//
//  FetchRecentProductQueriesUseCase.swift
//  CleanArchitectureExample
//
//  Created by Mehedi on 29/1/24.
//

import Foundation

// This is another option to create Use Case using more generic way
final class FetchRecentProductQueriesUseCase {

    struct RequestValue {
        let maxCount: Int
    }
    
    typealias ResultValue = (Result<[ProductQuery], Error>)
    private let requestValue: RequestValue
    
    private let completion: (ResultValue) -> Void
    private let productsQueriesRepository: ProductsQueriesRepositoryProtocol

    init(
        requestValue: RequestValue,
        completion: @escaping (ResultValue) -> Void,
        productsQueriesRepository: ProductsQueriesRepositoryProtocol
    ) {

        self.requestValue = requestValue
        self.completion = completion
        self.productsQueriesRepository = productsQueriesRepository
    }
    
}

extension FetchRecentProductQueriesUseCase: UseCase {
    
    
    func start() -> Cancellable? {
        self.productsQueriesRepository.fetchRecentsQueries(maxCount: requestValue.maxCount, completion: completion)
        return nil
    }
}

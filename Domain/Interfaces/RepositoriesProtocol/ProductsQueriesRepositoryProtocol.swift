//
//  File.swift
//  CleanArchitectureExample
//
//  Created by Mehedi on 29/1/24.
//

import Foundation

protocol ProductsQueriesRepositoryProtocol {
    func fetchRecentsQueries(
        maxCount: Int,
        completion: @escaping (Result<[ProductQuery], Error>) -> Void
    )
    func saveRecentQuery(
        query: ProductQuery,
        completion: @escaping (Result<ProductQuery, Error>) -> Void
    )
}

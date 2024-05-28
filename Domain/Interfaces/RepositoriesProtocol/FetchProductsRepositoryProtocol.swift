//
//  File.swift
//  APIDemo
//
//  Created by M M Mehedi Hasan on 2023/08/05.
//

import Foundation
import CoreData

protocol FetchProductsRepositoryProtocol {
    @discardableResult
    func fetchQuery(
        productsQuery: ProductQuery,
        limit: Int,
        skip: Int,
        cached: @escaping (ProductResponse?) -> Void,
        completion: @escaping (Result<(ProductResponse?), DataTransferError>) -> Void
    ) -> Cancellable?
}

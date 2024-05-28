//
//  AddProductsRepositoryProtocol.swift
//  CleanArchitectureExample
//
//  Created by Mehedi on 28/5/24.
//

import Foundation

protocol AddProductsRepositoryProtocol {
    @discardableResult
    func addNewProduct(
        productItem: ProductItem,
        completion: @escaping (Result<Bool?, DataTransferError>) -> Void
    ) -> Cancellable?
}

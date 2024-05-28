//
//  AddProductUseCase.swift
//  CleanArchitectureExample
//
//  Created by Mehedi on 28/5/24.
//

import Foundation

protocol AddProductUseCaseProtocol {
    func addNewProduct(id: Int32, completion: @escaping (Result<Bool?, DataTransferError>) -> Void) -> Cancellable?
}

class AddProductUseCase {
    
    private let addProductsRepositoryProtocol: AddProductsRepositoryProtocol
    
    init(
        addProductsRepositoryProtocol: AddProductsRepositoryProtocol
    ) {
        self.addProductsRepositoryProtocol = addProductsRepositoryProtocol
    }
    
}

extension AddProductUseCase: AddProductUseCaseProtocol {
    
    @discardableResult
    func addNewProduct(id: Int32, completion: @escaping (Result<Bool?, DataTransferError>) -> Void) -> Cancellable? {
        
        return self.addProductsRepositoryProtocol.addNewProduct(productItem: ProductItem.getDefaultData(with: id), completion: { result in
            
            switch result {
            case .success(_):
                completion(.success(true))
                
            case .failure(let error):
                completion(.failure(error))
            }
            
        })
    }
    
}

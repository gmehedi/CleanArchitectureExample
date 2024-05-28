//
//  AddProductUseCase.swift
//  CleanArchitectureExample
//
//  Created by Mehedi on 28/5/24.
//

import Foundation

protocol AddProductUseCaseProtocol {
    func addNewProduct(completion: @escaping (Result<Bool?, DataTransferError>) -> Void)
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
    
    func addNewProduct(completion: @escaping (Result<Bool?, DataTransferError>) -> Void) {
        self.addProductsRepositoryProtocol.addNewProduct(productItem: ProductItem.getDefaultData(with: 1), completion: { result in
            
            switch result {
            case .success(_):
                completion(.success(true))
                
            case .failure(let error):
                completion(.failure(error))
            }
            
        })
    }
    
}

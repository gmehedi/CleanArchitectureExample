//
//  AddProductRepository.swift
//  CleanArchitectureExample
//
//  Created by Mehedi on 28/5/24.
//

import Foundation

final class AddProductRepository {
    
    private let dataTransferService: DataTransferService
    private let backgroundQueue: DataTransferDispatchQueue
    
    init(
        dataTransferService: DataTransferService,
        backgroundQueue: DataTransferDispatchQueue = DispatchQueue.global(qos: .userInitiated)
    ) {
        self.dataTransferService = dataTransferService
        self.backgroundQueue = backgroundQueue
    }
}

extension AddProductRepository: AddProductsRepositoryProtocol {
    
    @discardableResult
    func addNewProduct(productItem: ProductItem, completion: @escaping (Result<Bool?, DataTransferError>) -> Void) -> Cancellable? {
        
        let productsItemRequest = productItem.toDictionary()
        
        let endpoint = APIEndpoints.getAddProductEndpoint(with: productsItemRequest)
        
        let task = RepositoryTask()
        
        guard !task.isCancelled else { return .none}
        
        task.networkTask =  self.dataTransferService.request(
            with: endpoint,
            on: self.backgroundQueue
        ) { result in
            
            switch result {
            case .success(_):
                completion(.success(true))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        return task
    }
    
}

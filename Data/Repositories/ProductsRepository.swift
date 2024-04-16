//
//  ProductsRepository.swift
//  APIDemo
//
//  Created by M M Mehedi Hasan on 2023/08/05.
//

import Foundation

final class ProductsRepository {
    
    private let dataTransferService: DataTransferService
    private let cacheProductsCoreDataStorage: ProductsCoreDataManagerProtocol //Cache
    private let backgroundQueue: DataTransferDispatchQueue
    
    init(
        dataTransferService: DataTransferService,
        cacheProductsCoreDataStorage: ProductsCoreDataManagerProtocol,
        backgroundQueue: DataTransferDispatchQueue = DispatchQueue.global(qos: .userInitiated)
    ) {
        self.dataTransferService = dataTransferService
        self.cacheProductsCoreDataStorage = cacheProductsCoreDataStorage
        self.backgroundQueue = backgroundQueue
    }
}

extension ProductsRepository: ProductsRepositoryProtocol {
    
    func fetchQuery(productsQuery: ProductQuery, page: Int, cached: @escaping (ProductResponse?) -> Void, completion: @escaping (Result<(ProductResponse?), DataTransferError>) -> Void) -> Cancellable? {
        
        let task = RepositoryTask()
        
        let requestDTO = ProductsRequestDTO(query: productsQuery.query, page: page)
        
        self.cacheProductsCoreDataStorage.getResponse(for: requestDTO, completion: { [weak self, backgroundQueue] result in
            
            guard let self = self else {
                return
            }
            
            if case let .success(responseDTO?) = result {
                cached(responseDTO.toDomain())
            }
            
            guard !task.isCancelled else { return }
            
            let productsRequest = ProductsRequestDTO(query: productsQuery.query, page: page)
            let endpoint = APIEndpoints.getProductResponse(with: productsRequest)
           
            task.networkTask = self.dataTransferService.request(
                with: endpoint,
                on: self.backgroundQueue
            ) { result in
                
                switch result {
                case .success(let responseDTO):
                    
                    self.cacheProductsCoreDataStorage.save(response: responseDTO, for: productsRequest)
                    completion(.success(responseDTO.toDomain()))
                    
                case .failure(let error):
                    
                    completion(.failure(error))
                }
            }
            
        })
        
        return task
    
    }
}

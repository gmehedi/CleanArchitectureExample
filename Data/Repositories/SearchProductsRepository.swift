//
//  SearchProductsRepository.swift
//  CleanArchitectureExample
//
//  Created by Mehedi on 27/5/24.
//

import Foundation

final class SearchProductsRepository {
    
    private let dataTransferService: DataTransferService
    private let cacheProductsCoreDataStorage: ProductsResponseCoreDataManagerProtocol //Cache
    private let backgroundQueue: DataTransferDispatchQueue
    
    init(
        dataTransferService: DataTransferService,
        cacheProductsCoreDataStorage: ProductsResponseCoreDataManagerProtocol,
        backgroundQueue: DataTransferDispatchQueue = DispatchQueue.global(qos: .userInitiated)
    ) {
        self.dataTransferService = dataTransferService
        self.cacheProductsCoreDataStorage = cacheProductsCoreDataStorage
        self.backgroundQueue = backgroundQueue
    }
}

extension SearchProductsRepository: FetchProductsRepositoryProtocol {
    
    func fetchQuery(productsQuery: ProductQuery, limit: Int, skip: Int, cached: @escaping (ProductResponse?) -> Void, completion: @escaping (Result<(ProductResponse?), DataTransferError>) -> Void) -> Cancellable? {
        
        let task = RepositoryTask()
        
        let requestDTO = ProductsRequestDTO(q: productsQuery.query, skip: skip, limit: limit)
        
        self.cacheProductsCoreDataStorage.getResponse(for: requestDTO, completion: { [weak self, backgroundQueue] result in
            
            guard let self = self else {
                return
            }
            
            if case let .success(responseDTO?) = result {
                cached(responseDTO.toDomain())
            }
            
            guard !task.isCancelled else { return }
            debugPrint("Query  ", productsQuery.query,"  ", skip,"  ", limit)
            let productsRequest = ProductsRequestDTO(q: productsQuery.query, skip: skip, limit: limit)
            
            let endpoint = APIEndpoints.getSearchProductsEndpoint(with: productsRequest)
           
            task.networkTask = self.dataTransferService.request(
                with: endpoint,
                on: backgroundQueue
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

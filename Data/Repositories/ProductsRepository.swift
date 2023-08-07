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
    
    func fetchQuery(productsQuery: ProductsQuery, cached: @escaping ([ProductItem]) -> Void, completion: @escaping (Result<ProductResponse, DataTransferError>) -> Void) -> Cancellable? {
        
        let task = RepositoryTask()
        
        self.cacheProductsCoreDataStorage.fetchProducts(completion: { [weak self] productItems in
            
            guard let self = self else { return }
            
            //Got cached Data
            cached(productItems)
            
            guard !task.isCancelled else { return }
            
            let productsRequest = ProductsRequestDTO(query: productsQuery.query, page: productsQuery.page)
            let endpoint = APIEndpoints.getProductResponse(with: productsRequest)
           
            task.networkTask = self.dataTransferService.request(
                with: endpoint,
                on: self.backgroundQueue
            ) { result in
                
                switch result {
                case .success(let responseDTO):
                    
                    let responseDomain = responseDTO.products.map({ $0.toDomain() })
                    
                    self.cacheProductsCoreDataStorage.saveProducts(products: responseDTO.products, completion: {_ in
                        
                    })
                    completion(.success(responseDTO.toDomain()))
                    
                case .failure(let error):
                    
                    completion(.failure(error))
                }
            }
            
        })
        
        return task
        
    }
}

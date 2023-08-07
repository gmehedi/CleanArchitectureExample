//
//  FetchProductsViewModel.swift
//  APIDemo
//
//  Created by M M Mehedi Hasan on 2023/08/06.
//

import Foundation

class FetchProductsViewModel {
   
    var result: Observable< (Result<ProductResponse, DataTransferError>)? > = Observable(nil)
    var cache: Observable< [ProductItem]? > = Observable(nil)
    
    let fetchProductsUseCase: FetchProductsUseCase
    
    init(fetchProductsUseCase: FetchProductsUseCase) {
        self.fetchProductsUseCase = fetchProductsUseCase
    }
    
}

extension FetchProductsViewModel {
    
    func fetchProducts() -> Cancellable? {
        
        let rquestValue = GetProductsUseCaseRquestValue(query: ProductsQuery(query: "", page: 1))
        
        return self.fetchProductsUseCase.execute(requestValue: rquestValue, cached: { products in
            self.cache.value = products
        }, completion: { result in
            self.result.value = result
        })
    }
}


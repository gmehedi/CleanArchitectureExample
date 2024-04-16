//
//  FetchProductsViewModel.swift
//  APIDemo
//
//  Created by M M Mehedi Hasan on 2023/08/06.
//

import Foundation

class FetchProductsViewModel {
   
    var currentPage: Int = 0
    var totalPageCount: Int = 1
    var hasMorePages: Bool { currentPage < totalPageCount }
    var nextPage: Int { hasMorePages ? currentPage + 1 : currentPage }
    
    private var pages: [ProductResponse] = []
    
    var result: Observable< (Result<ProductResponse?, DataTransferError>)? > = Observable(nil)
    var cache: Observable< ProductResponse? > = Observable(nil)
    
    let fetchProductsUseCase: FetchProductsUseCase
    
    init(fetchProductsUseCase: FetchProductsUseCase) {
        self.fetchProductsUseCase = fetchProductsUseCase
    }
    
}

extension FetchProductsViewModel {
    
    @discardableResult
    func fetchProducts() -> Cancellable? {
        
        let rquestValue = GetProductsUseCaseRquestValue(query: ProductQuery(query: ""), page: self.nextPage)
        
        return self.fetchProductsUseCase.execute(requestValue: rquestValue, cached: { products in
            if let productsList = products {
                self.cache.value = products
            }
           
        }, completion: { result in
            self.result.value = result
        })
    }
    
}


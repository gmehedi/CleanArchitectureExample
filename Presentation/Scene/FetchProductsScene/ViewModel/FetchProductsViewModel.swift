//
//  FetchProductsViewModel.swift
//  APIDemo
//
//  Created by M M Mehedi Hasan on 2023/08/06.
//

import UIKit

//protocol ProductResponseViewModelInput {
//    func viewDidLoad()
//    func didLoadNextPage()
//    func didSearch(query: String)
//    func didCancelSearch()
//    func showQueriesSuggestions()
//    func closeQueriesSuggestions()
//    func didSelectItem(at index: Int)
//}

class FetchProductsViewModel {
   
    var skip: Int = 0
    var limit: Int = 30
    var total: Int = 0
    
    public var error: Observable<DataTransferError?> = Observable(nil)

    public var items: Observable<[ProductItem]?> = Observable(nil) //so we can calculate view model items on demand:
   
    private var pages: [ProductResponse] = []
    
    let fetchProductsUseCase: FetchProductsUseCase
    
    init(fetchProductsUseCase: FetchProductsUseCase) {
        self.fetchProductsUseCase = fetchProductsUseCase
    }
    
}

extension FetchProductsViewModel {
    
    @discardableResult
    func fetchProducts() -> Cancellable? {

        let rquestValue = GetProductsUseCaseRquestValue(query:  ProductQuery(query: ""), limit: self.limit, skip: self.skip)
        
        debugPrint("PageNN  Fetch  ", self.skip,"  ", self.limit)
        
        return self.fetchProductsUseCase.execute(requestValue: rquestValue, cached: { [weak self] products in
            
            guard let self = self else {
                return
            }
            
            self.appenedProducts(productResponse: products)
           
        }, completion: {  [weak self] result in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success((let productResponse)):
                //debugPrint("APICALL   22222  ")
                self.appenedProducts(productResponse: productResponse)
                break
                
            case .failure(let error):
                //       debugPrint("APICALL   33333  ")
                self.error.value = error
                break
                
            }
            
           
        })
    }
    
    func didLoadNextPage() {
       
        self.skip += self.limit
        if self.skip >= self.total {
            return
        }
        
        self.fetchProducts()
    }

    func appenedProducts(productResponse: ProductResponse?) {
        
        guard let productResponse = productResponse, !productResponse.products.isEmpty else {
            self.error.value = .noResponse
            return
        }
        
        //debugPrint("PageNN    ", self.items.value?.count,"  ", pages.count )
        
        self.limit = Int(productResponse.limit)
        self.total = Int(productResponse.total)
        
        pages = pages
            .filter {
               // debugPrint("PageNN   Midd  ", $0.skip ,"    ", productResponse.skip )
                return $0.skip != productResponse.skip
            } + [productResponse]
        
       
        self.items.value = pages.productItems.sorted(by: {$0.id < $1.id})
        
        debugPrint("PageNN   END  ", self.limit,"  ",self.skip,"  ", self.total,"  ")
        
//        var i = 0
//        for pr in pages {
//            debugPrint("PageNN   PRRRR  MMM  ", pr.products.count,"   ", i,"  ", pr.limit)
//            i += 1
//        }
    }
    
}

// MARK: - Private

private extension Array where Element == ProductResponse {
    var productItems: [ProductItem] { flatMap { $0.products } }
}

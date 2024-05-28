//
//  AddNewDataViewModel.swift
//  CleanArchitectureExample
//
//  Created by Mehedi on 28/5/24.
//

import Foundation

class AddProductViewModel {
    
    let addProductUseCase: AddProductUseCase
    
    init(addProductUseCase: AddProductUseCase) {
        self.addProductUseCase = addProductUseCase
    }
    
}

extension AddProductViewModel {
    
    @discardableResult
    func addNewProducts(with id: Int32) -> Cancellable? {
       
        return self.addProductUseCase.addNewProduct(id: id, completion: { result in
            
            switch result {
            case .success(_):
                debugPrint("AddNewData  Succ")
            case .failure(let error):
                debugPrint("AddNewData  Error ", error)
            }
            
        })
    }
    
}

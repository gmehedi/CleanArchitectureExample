//
//  HistoryCpreDataManager.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/10.
//

import Foundation
import CoreData

final class ProductsCoreDataManager {
    
    private let coreDataStorage: CoreDataStorage
    
    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }
}

extension ProductsCoreDataManager: ProductsCoreDataManagerProtocol {
    
    func saveProducts(products: [ProductItemDTO], completion: @escaping ((Bool) -> Void)) {
        
        self.coreDataStorage.performBackgroundTask { context in
            
            let proctsEntity = products.map({$0.toEntity(context: context)})
            
            _ = proctsEntity.map({
                
                if $0.hasChanges {
                    do {
                        try context.save()
                        completion(true)
                    }
                    catch let error {
                        Logger.logPrintWith(text: error.localizedDescription)
                        completion(false)
                    }
                }else {
                    completion(false)
                }
                
            })
        }
    }
    
    
    func fetchProducts(completion: @escaping (([ProductItem]) -> Void)) {
        
        self.coreDataStorage.performBackgroundTask { context in
            
            let request: NSFetchRequest = ProductEntity.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: #keyPath(ProductEntity.createAt),
                                                        ascending: false)]
            do {
                let result = try context.fetch(request)
                completion( result.map( {$0.toDomain()} ) )
            }
            catch _ {
                completion([])
            }
        }
    }

}

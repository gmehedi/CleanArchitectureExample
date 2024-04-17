//
//  HistoryCpreDataManager.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/10.
//

import Foundation
import CoreData

final class ProductsQueriesCoreDataManager {
    
    private let coreDataStorage: CoreDataStorage
    private let maxStorageLimit: Int
    
    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared,
         maxStorageLimit: Int) {
        self.coreDataStorage = coreDataStorage
        self.maxStorageLimit = maxStorageLimit
    }
    
    private func fetchRequest(for requestDto: ProductsRequestDTO) -> NSFetchRequest<ProductsRequestEntity> {

         let request: NSFetchRequest = ProductsRequestEntity.fetchRequest()
         request.sortDescriptors = [NSSortDescriptor(key: #keyPath(ProductResponseItemEntity.createAt),
                                                     ascending: false)]
         request.predicate = NSPredicate(format: "%K = %@ AND %K = %d",
                                         #keyPath(ProductsRequestEntity.skip), requestDto.skip,
                                         #keyPath(ProductsRequestEntity.limit), requestDto.limit)
        return request
    }

    private func deleteResponse(
        for requestDto: ProductsRequestDTO,
        in context: NSManagedObjectContext
    ) {
        let request = fetchRequest(for: requestDto)

        do {
            if let result = try context.fetch(request).first {
                context.delete(result)
            }
        } catch {
            print(error)
        }
    }
}

extension ProductsQueriesCoreDataManager: ProductsQueriesRepositoryProtocol {
    
    func fetchRecentsQueries(maxCount: Int, completion: @escaping (Result<[ProductQuery], Error>) -> Void) {
        
    }
    
    func saveRecentQuery(query: ProductQuery, completion: @escaping (Result<ProductQuery, Error>) -> Void) {
        
    }
    
    
//    func getResponse(for request: ProductsRequestDTO, completion: @escaping (Result<ProductsResponseDTO?, Error>) -> Void) {
//        
//    }
//    
//    func save(response: ProductsResponseDTO, for requestDto: ProductsRequestDTO) {
//        
//    }
//    
//    
//    func saveProducts(products: [ProductItemDTO], completion: @escaping ((Bool) -> Void)) {
//        
//        self.coreDataStorage.performBackgroundTask { context in
//            
//            let proctsEntity = products.map({$0.toEntity(context: context)})
//            
//            _ = proctsEntity.map({
//                
//                if $0.hasChanges {
//                    do {
//                        try context.save()
//                        completion(true)
//                    }
//                    catch let error {
//                        Logger.logPrintWith(text: error.localizedDescription)
//                        completion(false)
//                    }
//                }else {
//                    completion(false)
//                }
//                
//            })
//        }
//    }
//    
//    
//    func fetchRecentsQueries(
//        maxCount: Int,
//        completion: @escaping (Result<[ProductQuery], Error>) -> Void
//    ) {
//        
//        coreDataStorage.performBackgroundTask { context in
//            do {
//                let request: NSFetchRequest = ProductQueryEntity.fetchRequest()
//                request.sortDescriptors = [NSSortDescriptor(key: #keyPath(ProductQueryEntity.createdAt),
//                                                            ascending: false)]
//                request.fetchLimit = maxCount
//                let result = try context.fetch(request).map { $0.toDomain() }
//
//                completion(.success(result))
//            } catch {
//                completion(.failure(CoreDataStorageError.readError(error)))
//            }
//        }
//    }
//
//    private func cleanUpQueries(
//        for query: ProductQuery,
//        inContext context: NSManagedObjectContext
//    ) throws {
//        let request: NSFetchRequest = ProductQueryEntity.fetchRequest()
//        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(ProductQueryEntity.createdAt),
//                                                    ascending: false)]
//        var result = try context.fetch(request)
//
//        removeDuplicates(for: query, in: &result, inContext: context)
//        removeQueries(limit: maxStorageLimit - 1, in: result, inContext: context)
//    }
//    
//    private func removeDuplicates(
//        for query: ProductQuery,
//        in queries: inout [ProductQueryEntity],
//        inContext context: NSManagedObjectContext
//    ) {
//        queries
//            .filter { $0.query == query.query }
//            .forEach { context.delete($0) }
//        queries.removeAll { $0.query == query.query }
//    }
//    
//    private func removeQueries(
//        limit: Int,
//        in queries: [ProductQueryEntity],
//        inContext context: NSManagedObjectContext
//    ) {
//        guard queries.count > limit else { return }
//
//        queries.suffix(queries.count - limit)
//            .forEach { context.delete($0) }
//    }
}

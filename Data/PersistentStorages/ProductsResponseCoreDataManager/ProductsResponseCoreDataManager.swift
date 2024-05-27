//
//  ProductsResponseCoreDataManager.swift
//  CleanArchitectureExample
//
//  Created by Mehedi on 29/1/24.
//

import Foundation
import CoreData

final class ProductsResponseCoreDataManager {

    private let coreDataStorage: CoreDataStorage

    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }

    // MARK: - Private

    private func fetchRequest(
        for requestDto: ProductsRequestDTO
    ) -> NSFetchRequest<ProductsRequestEntity> {
        
        // Print debug information
           debugPrint("Whattttt  ", requestDto.skip, "   ", requestDto.limit)
           
           // Create a fetch request for the ProductsRequestEntity entity
           let request: NSFetchRequest<ProductsRequestEntity> = ProductsRequestEntity.fetchRequest()
           
           // Construct the predicate safely
           var predicates: [NSPredicate] = []
           
           if let skipKeyPath = #keyPath(ProductsRequestEntity.skip) as String?,
              let limitKeyPath = #keyPath(ProductsRequestEntity.limit) as String? {
               let skipPredicate = NSPredicate(format: "%K = %@", skipKeyPath, NSNumber(value: requestDto.skip))
               let limitPredicate = NSPredicate(format: "%K = %d", limitKeyPath, requestDto.limit)
               
               predicates.append(skipPredicate)
               predicates.append(limitPredicate)
           }
           
           // Combine predicates using AND operator
           if !predicates.isEmpty {
               request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
           }
           
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

extension ProductsResponseCoreDataManager: ProductsResponseCoreDataManagerProtocol {
    
    func getResponse(for requestDto: ProductsRequestDTO, completion: @escaping (Result<ProductResponseDTO?, Error>) -> Void) {
        
        coreDataStorage.performBackgroundTask { context in
            do {
                let fetchRequest = self.fetchRequest(for: requestDto)
                let requestEntity = try context.fetch(fetchRequest).first
                
                completion(.success(requestEntity?.productsResponse?.toDTO()))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
        //completion(.success(nil))
    }
    
    func save(response: ProductResponseDTO, for requestDto: ProductsRequestDTO) {
        
        coreDataStorage.performBackgroundTask { context in
            do {
                self.deleteResponse(for: requestDto, in: context)

                let requestEntity = requestDto.toEntity(in: context)
                requestEntity.productsResponse = response.toEntity(in: context)

                try context.save()
            } catch {
                // TODO: - Log to Crashlytics
                debugPrint("CoreDataMoviesResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }
    

//    func getResponse(
//        for requestDto: MoviesRequestDTO,
//        completion: @escaping (Result<MoviesResponseDTO?, Error>) -> Void
//    ) {
//        coreDataStorage.performBackgroundTask { context in
//            do {
//                let fetchRequest = self.fetchRequest(for: requestDto)
//                let requestEntity = try context.fetch(fetchRequest).first
//
//                completion(.success(requestEntity?.response?.toDTO()))
//            } catch {
//                completion(.failure(CoreDataStorageError.readError(error)))
//            }
//        }
//    }
//
//    func save(
//        response responseDto: MoviesResponseDTO,
//        for requestDto: MoviesRequestDTO
//    ) {
//        coreDataStorage.performBackgroundTask { context in
//            do {
//                self.deleteResponse(for: requestDto, in: context)
//
//                let requestEntity = requestDto.toEntity(in: context)
//                requestEntity.response = responseDto.toEntity(in: context)
//
//                try context.save()
//            } catch {
//                // TODO: - Log to Crashlytics
//                debugPrint("CoreDataMoviesResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
//            }
//        }
//    }
}

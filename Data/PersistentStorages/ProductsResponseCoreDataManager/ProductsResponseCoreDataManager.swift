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
        let request: NSFetchRequest = ProductsRequestEntity.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@ AND %K = %d",
                                        #keyPath(ProductsRequestEntity.query), requestDto.query,
                                        #keyPath(ProductsRequestEntity.page), requestDto.page)
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

extension ProductsResponseCoreDataManager: ProductsCoreDataManagerProtocol {
    
    func getResponse(for request: ProductsRequestDTO, completion: @escaping (Result<ProductsResponseDTO?, Error>) -> Void) {
        
    }
    
    func save(response: ProductsResponseDTO, for requestDto: ProductsRequestDTO) {
        
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

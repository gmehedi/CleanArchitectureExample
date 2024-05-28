//
//  FetchProductsDIContainer.swift
//  APIDemo
//
//  Created by M M Mehedi Hasan on 2023/08/06.
//

import Foundation

final class FetchProductsDIContainer: AppDIContainer {
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }
    
    // MARK: - Dependencies
    private let dependencies: Dependencies
      
    // MARK: - Inject Dependencies
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Persistent Storage
    lazy var fetchProductsResponseCache: ProductsResponseCoreDataManager = ProductsResponseCoreDataManager(coreDataStorage:  CoreDataStorage.shared)
    
    // MARK: - Persistent Storage
    lazy var productsResponseCoreDataManager: ProductsResponseCoreDataManagerProtocol = ProductsResponseCoreDataManager(coreDataStorage: CoreDataStorage.shared)

    // MARK: - Make Products Repository
    func getProductsRepositoryProtocol() -> FetchProductsRepository {
        return FetchProductsRepository(dataTransferService: self.dependencies.apiDataTransferService, cacheProductsCoreDataStorage: self.productsResponseCoreDataManager)
    }
    
    // MARK: - Make Product Use Case
    func makeFetchProductsUseCase() -> FetchProductsUseCase {
        return FetchProductsUseCase(productsRepositoryProtocol: getProductsRepositoryProtocol(), productsResponseCoreDataManager: self.fetchProductsResponseCache)
    }
    
    // MARK: - Make Chatting View Model
    func makeFetchProductsViewModel() -> FetchProductsViewModel {
        return FetchProductsViewModel(fetchProductsUseCase: self.makeFetchProductsUseCase())
    }
    
    // MARK: - Flow Coordinators
    func makeFetchProductsFlowCoordinator(navigationController: RootNavigationController) -> FetchProductsFlowCoordinator {
        return FetchProductsFlowCoordinator(
            navigationController: navigationController, appDIContainer: self
        )
    }
    
}

// MARK: - Flow Coordinators
extension FetchProductsDIContainer {
    
    func makeFetchProductsViewController() -> FetchProductsViewController {
        return FetchProductsViewController.create(with: self.makeFetchProductsViewModel())
    }
}

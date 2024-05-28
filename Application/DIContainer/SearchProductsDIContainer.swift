//
//  SearchProductsDIContainer.swift
//  CleanArchitectureExample
//
//  Created by Mehedi on 27/5/24.
//

import Foundation

final class SearchProductsDIContainer: AppDIContainer {
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }
    
    // MARK: - Dependencies
    private let dependencies: Dependencies

  //  private let appDIContainer =  AppDIContainer()
      
    // MARK: - Inject Dependencies
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Persistent Storage
    lazy var searchProductsResponseCache: ProductsResponseCoreDataManager = ProductsResponseCoreDataManager(coreDataStorage:  CoreDataStorage.shared)
    
    // MARK: - Persistent Storage
    lazy var productsResponseCoreDataManager: ProductsResponseCoreDataManagerProtocol = ProductsResponseCoreDataManager(coreDataStorage: CoreDataStorage.shared)
    
    
    // MARK: - Persistent Storage
    lazy var productsQueriesRepositoryCache: ProductsQueriesCoreDataManager = ProductsQueriesCoreDataManager(coreDataStorage: CoreDataStorage.shared, maxStorageLimit: 100)
    

    // MARK: - Make Products Repository
    func getSearchProductsRepositoryProtocol() -> SearchProductsRepository {
        return SearchProductsRepository(dataTransferService: self.dependencies.apiDataTransferService, cacheProductsCoreDataStorage: self.productsResponseCoreDataManager)
    }
    
    // MARK: - Make Product Use Case
    func makeSearchProductsUseCase() -> SearchProductsUseCase {
        return SearchProductsUseCase(productsRepositoryProtocol: self.getSearchProductsRepositoryProtocol(), productsResponseCoreDataManager: self.searchProductsResponseCache)
    }
    
    // MARK: - Make Chatting View Model
    func makeSearchProductsViewModel() -> SearchProductsViewModel {
        return SearchProductsViewModel(searchProductsUseCase: self.makeSearchProductsUseCase())
    }
    
    // MARK: - Flow Coordinators
    func makeSearchProductsFlowCoordinator(navigationController: RootNavigationController) -> SearchProductsFlowCoordinator {
        return SearchProductsFlowCoordinator(
            navigationController: navigationController, appDIContainer: self
        )
    }
    
}

// MARK: - Flow Coordinators
extension SearchProductsDIContainer {
    
    func makeSearchProductsViewController() -> SearchProductsViewController {
        return SearchProductsViewController.create(with: self.makeSearchProductsViewModel())
    }
}

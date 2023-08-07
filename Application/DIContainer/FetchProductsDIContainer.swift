//
//  FetchProductsDIContainer.swift
//  APIDemo
//
//  Created by M M Mehedi Hasan on 2023/08/06.
//

import Foundation

final class FetchProductsDIContainer {
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }
    
    // MARK: - Dependencies
    private let dependencies: Dependencies

    private let appDIContainer =  AppDIContainer()
      
    // MARK: - Inject Dependencies
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    // MARK: - Persistent Storage
    lazy var fetchProductsResponseCache: ProductsCoreDataManager = ProductsCoreDataManager(coreDataStorage: CoreDataStorage.shared)
    
    // MARK: - Make Products Repository
    func makeFetchProductRepository() -> ProductsRepositoryProtocol {
        return ProductsRepository(dataTransferService: self.dependencies.apiDataTransferService, cacheProductsCoreDataStorage: fetchProductsResponseCache)
    }
    
    // MARK: - Make Product Use Case
    func makeFetchProductsUseCase() -> FetchProductsUseCase {
        return FetchProductsUseCase(productsRepositoryProtocol: self.makeFetchProductRepository())
    }
    
    // MARK: - Make Chatting View Model
    func makeFetchProductsViewModel() -> FetchProductsViewModel {
        return FetchProductsViewModel(fetchProductsUseCase: self.makeFetchProductsUseCase())
    }
    
    // MARK: - Flow Coordinators
    func makeFetchProductsFlowCoordinator(navigationController: RootNavigationController) -> FetchProductsFlowCoordinator {
        return FetchProductsFlowCoordinator(
            navigationController: navigationController, appDIContainer: appDIContainer
        )
    }
    
}

// MARK: - Flow Coordinators
extension FetchProductsDIContainer {
    
    func makeFetchProductsViewController() -> FetchProductsViewController {
        return FetchProductsViewController.create(with: self.makeFetchProductsViewModel())
    }
}

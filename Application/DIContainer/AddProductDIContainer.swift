//
//  AddProductDIContainer.swift
//  CleanArchitectureExample
//
//  Created by Mehedi on 28/5/24.
//

import Foundation

final class AddProductDIContainer: AppDIContainer {
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }
    
    // MARK: - Dependencies
    private let dependencies: Dependencies

    // MARK: - Inject Dependencies
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Make Products Repository
    func getAddProductRepository() -> AddProductRepository {
        return AddProductRepository(dataTransferService: self.dependencies.apiDataTransferService)
    }
    
    // MARK: - Make Product Use Case
    func makeSearchProductsUseCase() -> AddProductUseCase {
        return AddProductUseCase(addProductsRepositoryProtocol: self.getAddProductRepository())
    }
    
    // MARK: - Make Chatting View Model
    func makeAddProductViewModel() -> AddProductViewModel {
        return AddProductViewModel(addProductUseCase: self.makeSearchProductsUseCase())
    }
    
    // MARK: - Flow Coordinators
    func makeAddProductFlowCoordinator(navigationController: RootNavigationController) -> AddProductFlowCoordinator {
        return AddProductFlowCoordinator(
            navigationController: navigationController, appDIContainer: self
        )
    }
    
}

// MARK: - Flow Coordinators
extension AddProductDIContainer {
    
    func makeAddProductViewController() -> AddProductViewController {
        return AddProductViewController.create(with: self.makeAddProductViewModel())
    }
}

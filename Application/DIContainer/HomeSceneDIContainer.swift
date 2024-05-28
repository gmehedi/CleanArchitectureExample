//
//  HomeDIContainer.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/13.
//

import Foundation

final class HomeSceneDIContainer: AppDIContainer {
    
    struct Dependencies {
    }
    
    // MARK: - Dependencies
    private let dependencies: Dependencies

  //  private let appDIContainer =  AppDIContainer()
      
    // MARK: - Inject Dependencies
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Make Chatting View Model
    func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel()
    }
    
    // MARK: - Flow Coordinators
    func makeHomeFlowCoordinator(navigationController: RootNavigationController) -> HomeFlowCoordinator {
        return HomeFlowCoordinator(
            navigationController: navigationController, appDIContainer: self
        )
    }
    
}

// MARK: - Flow Coordinators
extension HomeSceneDIContainer {
    
    func makeHomeViewController() -> HomeViewController {
        return HomeViewController.create(with: self.makeHomeViewModel(), homeMenuModel: self.getHomeMenuModel())
    }
    
    func getHomeMenuModel() -> [HomeMenuModel] {
        
        return [
            HomeMenuModel(title: "Get Products", iconName: "getProducts", actionType: .getProduct),
            HomeMenuModel(title: "Search Products", iconName: "searchProducts", actionType: .searchProduct)
        ]
        
    }
    
}

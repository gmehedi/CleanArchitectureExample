//
//  ChattingFlowCoordinator.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/13.
//

import UIKit

final class HomeFlowCoordinator: BaseCoordinator {
    
    
    private let appDIContainer: AppDIContainer
    
    private weak var homeVC: HomeViewController?
    
    var childoordinator = [BaseCoordinator]()
    private weak var navigationController: RootNavigationController?
    
    init(navigationController: RootNavigationController,
         appDIContainer: AppDIContainer) {
        
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        
        if let nav = self.navigationController {
            let homeDIContainer = self.appDIContainer.makeHomeSceneDIContainer()
            let vc = homeDIContainer.makeHomeViewController()
            vc.coordinator = self
            nav.pushViewController(vc, animated: true)
            self.homeVC = vc
        }
    }
    
    func dismissVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK: Go to Fetch ProductVC
extension HomeFlowCoordinator {
    
    func goToFetchProductsViewController() {
        
        if let nav = self.navigationController {
            let fetchProductsDIContainer = self.appDIContainer.makeFetchProductsSceneDIContainer()
            let coordinator = fetchProductsDIContainer.makeFetchProductsFlowCoordinator(navigationController: nav)
            self.childoordinator.append(coordinator)
            coordinator.start()
        }
    }
    
    func goToSearchProductsViewController() {
        
        if let nav = self.navigationController {
            let searchProductsDIContainer = self.appDIContainer.makeSearchProductsSceneDIContainer()
            let coordinator = searchProductsDIContainer.makeSearchProductsFlowCoordinator(navigationController: nav)
            self.childoordinator.append(coordinator)
            coordinator.start()
        }
    }
    
    func goToAddProductViewController() {
        
        if let nav = self.navigationController {
            let addProductDIContainer = self.appDIContainer.makeAddProductSceneDIContainer()
            let coordinator = addProductDIContainer.makeAddProductFlowCoordinator(navigationController: nav)
            self.childoordinator.append(coordinator)
            coordinator.start()
        }
    }
    
}

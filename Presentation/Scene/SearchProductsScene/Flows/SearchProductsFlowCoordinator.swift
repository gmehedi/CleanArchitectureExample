//
//  FetchProductsFlowCoordinator.swift
//  CleanArchitectureExample
//
//  Created by Mehedi on 27/5/24.
//

import UIKit

final class SearchProductsFlowCoordinator: BaseCoordinator {
    
    
    private let appDIContainer: AppDIContainer
    
    private weak var fetchProductsVC: SearchProductsViewController?
    
    var childoordinator = [BaseCoordinator]()
    private weak var navigationController: RootNavigationController?
    
    init(navigationController: RootNavigationController,
         appDIContainer: AppDIContainer) {
        
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        
        if let nav = self.navigationController {
            let searchProductsDIContainer = self.appDIContainer.makeSearchProductsSceneDIContainer()
            let vc = searchProductsDIContainer.makeSearchProductsViewController()
            vc.coordinator = self
            nav.pushViewController(vc, animated: true)
            self.fetchProductsVC = vc
        }
    }
    
    func dismissVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

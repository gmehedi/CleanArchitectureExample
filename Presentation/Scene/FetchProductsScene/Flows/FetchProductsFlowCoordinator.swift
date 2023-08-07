//
//  FetchProductsFlowCoordinator.swift
//  APIDemo
//
//  Created by M M Mehedi Hasan on 2023/08/06.
//


import UIKit

final class FetchProductsFlowCoordinator: BaseCoordinator {
    
    
    private let appDIContainer: AppDIContainer
    
    private weak var fetchProductsVC: FetchProductsViewController?
    
    var childoordinator = [BaseCoordinator]()
    private weak var navigationController: RootNavigationController?
    
    init(navigationController: RootNavigationController,
         appDIContainer: AppDIContainer) {
        
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        
        if let nav = self.navigationController {
            let fetchProductsDIContainer = self.appDIContainer.makeFetchProductsSceneDIContainer()
            let vc = fetchProductsDIContainer.makeFetchProductsViewController()
            vc.coordinator = self
            nav.pushViewController(vc, animated: true)
            self.fetchProductsVC = vc
        }
    }
    
    func dismissVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//
//  AddProductFlowCoordinator.swift
//  CleanArchitectureExample
//
//  Created by Mehedi on 28/5/24.
//

import UIKit

final class AddProductFlowCoordinator: BaseCoordinator {
    
    
    private let appDIContainer: AppDIContainer
    
    private weak var addProductVC: AddProductViewController?
    
    var childoordinator = [BaseCoordinator]()
    private weak var navigationController: RootNavigationController?
    
    init(navigationController: RootNavigationController,
         appDIContainer: AppDIContainer) {
        
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        
        if let nav = self.navigationController {
            let addProductDIContainer = self.appDIContainer.makeAddProductSceneDIContainer()
            let vc = addProductDIContainer.makeAddProductViewController()
            vc.coordinator = self
            nav.pushViewController(vc, animated: true)
            self.addProductVC = vc
        }
    }
    
    func dismissVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
}


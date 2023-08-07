//
//  SplashFlowCoordinator.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/16.
//

import UIKit

protocol SplashFlowCoordinatorDependencies  {
    func makeSplashViewController(
    ) -> SplashViewController
}

final class SplashFlowCoordinator: BaseCoordinator {
  
    private let appDIContainer: AppDIContainer

    private weak var homeVC: HomeViewController?
    private weak var splashVC: SplashViewController?
    
    var childoordinator = [BaseCoordinator]()
    private weak var navigationController: RootNavigationController?

    init(navigationController: RootNavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        
        let splashDIContainer = self.appDIContainer.makeSplashSceneDIContainer()
        
        let vc = splashDIContainer.makeSplashViewController()
        vc.coordinator = self
        self.splashVC = vc
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SplashFlowCoordinator {
    
//    func goToHomeVC() {
//        
//        let homeDIContainer = self.appDIContainer.makeHomeSceneDIContainer()
//        
//        if let nav = self.navigationController {
//            let homeCoordinator = homeDIContainer.makeHomeFlowCoordinator(navigationController: nav)
//            self.childoordinator.append(homeCoordinator)
//            homeCoordinator.start()
//        }
//    }
}

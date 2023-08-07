//
//  AppFlowCoordinator.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/12.
//

import UIKit

final class AppFlowCoordinator: BaseCoordinator {

    var navigationController: RootNavigationController
    
    private let appDIContainer: AppDIContainer
    
    var childoordinator = [BaseCoordinator]()
    
    init(
        navigationController: RootNavigationController,
        appDIContainer: AppDIContainer
    ) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        // In App Flow we can check if user needs to login, if yes we would run login flow
        let splashSceneDIContainer = appDIContainer.makeSplashSceneDIContainer()
        let coordinator = splashSceneDIContainer.makeSplashFlowCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childoordinator.append(coordinator)
    }
    
}

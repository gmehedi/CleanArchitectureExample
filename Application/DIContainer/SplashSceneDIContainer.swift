//
//  SplashDIContainer.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/16.
//

import Foundation

final class SplashSceneDIContainer: AppDIContainer {
    
    struct Dependencies {
    }
    
    // MARK: - Dependencies
    private let dependencies: Dependencies

    // MARK: - Inject Dependencies
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Flow Coordinators
    func makeSplashFlowCoordinator(navigationController: RootNavigationController) -> SplashFlowCoordinator {
        return SplashFlowCoordinator(
            navigationController: navigationController, appDIContainer: self
        )
    }
    
}

// MARK: - Flow Coordinators
extension SplashSceneDIContainer {
    
    func makeSplashViewController() -> SplashViewController {
        return SplashViewController.create()
    }
    
}

//
//  BaseCoordinator.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/18.
//

import Foundation
import UIKit

protocol BaseCoordinator {

    var childoordinator: [BaseCoordinator] { get set }
    
    init(
        navigationController: RootNavigationController,
        appDIContainer: AppDIContainer
    )

    func start()
    
}

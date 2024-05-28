//
//  √.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/12.
//

import Foundation
 
class AppDIContainer {
    
    lazy var appConfiguration = AppConfiguration()
    
    // MARK: - Network
    lazy var productAPIDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(
            baseURL: URL(string: appConfiguration.productsApiBaseURL)!,
            queryParameters: [
                "language": NSLocale.preferredLanguages.first ?? "en"
            ]
        )
        
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()
    
    
    // MARK: - DIContainers of scenes
    func makeSplashSceneDIContainer() -> SplashSceneDIContainer {
        let dependencies = SplashSceneDIContainer.Dependencies()
        return SplashSceneDIContainer(dependencies: dependencies)
    }
    
    // MARK: - DIContainers of scenes
    func makeHomeSceneDIContainer() -> HomeSceneDIContainer {
        
        let dependencies = HomeSceneDIContainer.Dependencies()
        return HomeSceneDIContainer(dependencies: dependencies)
    }
    
    // MARK: - DIContainers of scenes
    func makeFetchProductsSceneDIContainer() -> FetchProductsDIContainer {
        
        let dependencies = FetchProductsDIContainer.Dependencies(apiDataTransferService: productAPIDataTransferService)
        return FetchProductsDIContainer(dependencies: dependencies)
    }
    
    // MARK: - DIContainers of scenes
    func makeSearchProductsSceneDIContainer() -> SearchProductsDIContainer {
        
        let dependencies = SearchProductsDIContainer.Dependencies(apiDataTransferService: productAPIDataTransferService)
        return SearchProductsDIContainer(dependencies: dependencies)
    }
    
    // MARK: - DIContainers of scenes
    func makeAddProductSceneDIContainer() -> AddProductDIContainer {
        let dependencies = AddProductDIContainer.Dependencies(apiDataTransferService: productAPIDataTransferService)
        return AddProductDIContainer(dependencies: dependencies)
    }
    
}


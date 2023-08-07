//
//  AppDelegate.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/09.
//

import UIKit
import CoreData

//pass: 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

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    let appDIContainer = AppDIContainer()
    var appFlowCoordinator: AppFlowCoordinator?
    var homeCoordintator: HomeFlowCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // self.setupRootVC()
        self.setSplashCoorditanor()
        return true
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "ChatGPTiOS")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        CoreDataStorage.shared.saveContext()
    }
    
}

extension AppDelegate {
    
    private func setSplashCoorditanor() {
        if self.window == nil {
            self.window = UIWindow(frame: UIScreen.main.bounds)
        }
        
        let rootNavigationController = RootNavigationController()
        
        self.window?.rootViewController = rootNavigationController
        
        self.appFlowCoordinator = AppFlowCoordinator(
            navigationController: rootNavigationController,
            appDIContainer: self.appDIContainer
        )
        
        self.appFlowCoordinator?.start()
        self.window?.makeKeyAndVisible()
        
        UIView.transition(with: self.window!,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
    
    public func setHomeCoorditanor() {
        if self.window == nil {
            self.window = UIWindow(frame: UIScreen.main.bounds)
        }
        
        let rootNavigationController = RootNavigationController()
        
        self.window?.rootViewController = rootNavigationController
        let homeDIContainer = self.appDIContainer.makeHomeSceneDIContainer()
        
        let homeCoordinator = homeDIContainer.makeHomeFlowCoordinator(navigationController: rootNavigationController)
        self.homeCoordintator = homeCoordinator
        homeCoordinator.start()
        self.window?.makeKeyAndVisible()
        
        UIView.transition(with: self.window!,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
        
    }
    
}

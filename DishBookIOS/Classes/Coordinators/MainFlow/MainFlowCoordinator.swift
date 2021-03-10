//
//  MainFlowCoordinator.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 30.01.2021.
//

import UIKit

final class MainFlowCoordinator: BaseCoordinator {
    
    let window: UIWindow
    let tabBarController: UITabBarController
    
    // MARK: - Coordinator tabs
    
    var exploreCoordinator: ExploreCoordinator?
    var dishBookCoordinator: DishBookCoordinator?
    var newDishCoordinator: NewDishCoordinator?
    var shoplistCoordinator: ShoplistCoordinator?
    var profileCoordinator: ProfileCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        self.tabBarController = UITabBarController()
        
        super.init()
    }
    
    override func start() {
        
        var controllers: [UIViewController] = []
        
        exploreCoordinator = ExploreCoordinator()
        dishBookCoordinator = DishBookCoordinator()
        newDishCoordinator = NewDishCoordinator()
        shoplistCoordinator = ShoplistCoordinator()
        profileCoordinator = ProfileCoordinator()
        
        let exploreRootViewController = exploreCoordinator!.rootViewController!
        exploreRootViewController.tabBarItem = exploreCoordinator?.tabItem
        
        let dishBookRootViewController = dishBookCoordinator!.rootViewController!
        dishBookRootViewController.tabBarItem = dishBookCoordinator?.tabItem
        
        let newDishRootViewController = newDishCoordinator!.rootViewController!
        newDishRootViewController.tabBarItem = newDishCoordinator?.tabItem
        
        let shoplistRootViewController = shoplistCoordinator!.rootViewController!
        shoplistRootViewController.tabBarItem = shoplistCoordinator?.tabItem
        
        let profileRootViewController = profileCoordinator!.rootViewController!
        profileRootViewController.tabBarItem = profileCoordinator?.tabItem
        
        controllers.append(exploreRootViewController)
        controllers.append(dishBookRootViewController)
        controllers.append(newDishRootViewController)
        controllers.append(shoplistRootViewController)
        controllers.append(profileRootViewController)
        
        tabBarController.delegate = self
        tabBarController.viewControllers = controllers
        tabBarController.tabBar.tintColor = R.color.primaryOrangeMuted()
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}

// MARK: - UITabBarControllerDelegate

extension MainFlowCoordinator: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        print("tabBarController didSelect")
    }
}

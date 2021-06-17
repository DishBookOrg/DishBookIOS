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
        
        let exploreCoordinator = ExploreCoordinator()
        self.exploreCoordinator = exploreCoordinator
        childCoordinators.append(exploreCoordinator)

        let dishBookCoordinator = DishBookCoordinator()
        self.dishBookCoordinator = dishBookCoordinator
        childCoordinators.append(dishBookCoordinator)
        
        let newDishCoordinator = NewDishCoordinator()
        self.newDishCoordinator = newDishCoordinator
        childCoordinators.append(newDishCoordinator)
        
        let shoplistCoordinator = ShoplistCoordinator()
        self.shoplistCoordinator = shoplistCoordinator
        childCoordinators.append(shoplistCoordinator)
        
        let profileCoordinator = ProfileCoordinator()
        self.profileCoordinator = profileCoordinator
        childCoordinators.append(profileCoordinator)
        
        let exploreRootViewController = exploreCoordinator.rootViewController!
        exploreRootViewController.tabBarItem = exploreCoordinator.tabItem
        
        let dishBookRootViewController = dishBookCoordinator.rootViewController!
        dishBookRootViewController.tabBarItem = dishBookCoordinator.tabItem
        
        let newDishRootViewController = newDishCoordinator.rootViewController!
        newDishRootViewController.tabBarItem = newDishCoordinator.tabItem
        
        let shoplistRootViewController = shoplistCoordinator.rootViewController!
        shoplistRootViewController.tabBarItem = shoplistCoordinator.tabItem
        
        let profileRootViewController = profileCoordinator.rootViewController!
        profileRootViewController.tabBarItem = profileCoordinator.tabItem
        
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
        
        print("tabBarController didSelect \((viewController as? UINavigationController)?.viewControllers.first?.description ?? "")")
    }
}

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
    
    init(window: UIWindow) {
        self.window = window
        self.tabBarController = UITabBarController()
        
        super.init()
    }
    
    override func start() {
        
        var controllers: [UIViewController] = []
        
        exploreCoordinator = ExploreCoordinator(navigationController: UINavigationController())
        dishBookCoordinator = DishBookCoordinator(navigationController: UINavigationController())
        
        exploreCoordinator?.start()
        dishBookCoordinator?.start()
        
        let exploreRootViewController = exploreCoordinator!.rootViewController!
        exploreRootViewController.tabBarItem = UITabBarItem(title: R.string.explore.explore(),
                                                            image: R.image.search(),
                                                            selectedImage: UIImage())
        
        let dishBookRootViewController = dishBookCoordinator!.rootViewController!
        dishBookRootViewController.tabBarItem = UITabBarItem(title: R.string.dishBook.dishBook(),
                                                             image: R.image.dishBook(),
                                                             selectedImage: UIImage())
        
        controllers.append(exploreRootViewController)
        controllers.append(dishBookRootViewController)
        
        tabBarController.delegate = self
        tabBarController.viewControllers = controllers
        
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

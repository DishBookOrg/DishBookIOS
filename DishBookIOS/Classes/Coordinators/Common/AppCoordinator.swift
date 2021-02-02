//
//  AppCoordinator.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 30.01.2021.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        super.init()
    }
    
    override func start() {
        
        let navigationController = UINavigationController()
        
        var coordinator: BaseCoordinator!
        
        if App.user != nil {
        
            coordinator = MainFlowCoordinator(window: window)
            
        } else {
            
            coordinator = AuthCoordinator(navigationController: navigationController)
            coordinator.isCompleted = { [weak self] in
                
                self?.free(coordinator: coordinator)
                self?.start()
            }
            
            store(coordinator: coordinator)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
        coordinator.start()
    }
    
    func logout() {
        
        childCoordinators.removeAll()
        start()
    }
}

//
//  BaseRootCoordinator.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 02.02.2021.
//

import UIKit

class BaseRootCoordinator: BaseFlowCoordinator {
    
    var tabItem: UITabBarItem?
    
    var rootViewController: UIViewController? {
        return navigationController
    }
    
    init() {
        super.init(navigationController: UINavigationController())
    }
}

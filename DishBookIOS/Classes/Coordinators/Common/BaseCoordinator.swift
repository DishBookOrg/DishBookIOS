//
//  BaseCoordinator.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 30.01.2021.
//

import UIKit

class BaseCoordinator: NSObject, CoordinatorProtocol {
    
    var childCoordinators: [CoordinatorProtocol] = []
    var isCompleted: (() -> Void)?
    
    func start() {
        fatalError("Children should implement `start`.")
    }
}

class BaseFlowCoordinator: BaseCoordinator {
    
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        navigationController?.isNavigationBarHidden = true
        self.navigationController = navigationController
    }
    
    var rootViewController: UIViewController? {
        return navigationController
    }
}

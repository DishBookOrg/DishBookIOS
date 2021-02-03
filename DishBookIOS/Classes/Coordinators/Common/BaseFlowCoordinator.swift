//
//  BaseFlowCoordinator.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 02.02.2021.
//

import UIKit

class BaseFlowCoordinator: BaseCoordinator {
    
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        navigationController?.isNavigationBarHidden = true
        
        self.navigationController = navigationController
    }
}

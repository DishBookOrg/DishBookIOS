//
//  BaseFlowCoordinator.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 02.02.2021.
//

import UIKit
import Combine

class BaseFlowCoordinator: BaseCoordinator {
    
    var navigationController: UINavigationController?
    var cancelableSet: Set<AnyCancellable> = []
    
    init(navigationController: UINavigationController?) {
        navigationController?.isNavigationBarHidden = true
        
        self.navigationController = navigationController
    }
}

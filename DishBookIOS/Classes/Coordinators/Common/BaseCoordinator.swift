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

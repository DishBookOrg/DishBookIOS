//
//  CoordinatorProtocol.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 30.01.2021.
//

import Foundation

protocol CoordinatorProtocol: class {
    
    var childCoordinators: [CoordinatorProtocol] { get set }
    
    func start()
}

extension CoordinatorProtocol {
    
    func store(coordinator: CoordinatorProtocol) {
        childCoordinators.append(coordinator)
    }
    
    func free(coordinator: CoordinatorProtocol) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}

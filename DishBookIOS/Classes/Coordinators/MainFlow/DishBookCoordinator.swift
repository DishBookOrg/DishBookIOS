//
//  DishBookCoordinator.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 02.02.2021.
//

import UIKit

final class DishBookCoordinator: BaseFlowCoordinator {
    
    override init(navigationController: UINavigationController?) {
        super.init(navigationController: navigationController)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func start() {
        
        let viewModel = DishBookViewModel()
        let dishBookController = DishBookViewController.create(viewModel: viewModel)
        navigationController?.pushViewController(dishBookController, animated: false)
    }
}

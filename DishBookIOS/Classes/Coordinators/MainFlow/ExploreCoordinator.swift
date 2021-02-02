//
//  ExploreCoordinator.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 30.01.2021.
//

import UIKit

final class ExploreCoordinator: BaseFlowCoordinator {
    
    var tabBarController: UITabBarController?
    
    override init(navigationController: UINavigationController?) {
        super.init(navigationController: navigationController)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func start() {
        
        let viewModel = ExploreViewModel()
        let exploreController = ExploreViewController.create(viewModel: viewModel)
        navigationController?.pushViewController(exploreController, animated: false)
    }
}

//
//  NewDishCoordinator.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 02.02.2021.
//

import UIKit

final class NewDishCoordinator: BaseRootCoordinator {
        
    override init() {
        super.init()
        
        self.tabItem = UITabBarItem(title: R.string.common.new(),
                                    image: R.image.plus(),
                                    selectedImage: R.image.plus()?.withTintColor(R.color.primaryOrangeMuted()!,
                                                                                 renderingMode: .alwaysOriginal))
        navigationController?.isNavigationBarHidden = false
        start()
    }
    
    override func start() {
        
        let viewModel = NewDishViewModel()
        let newDishViewController = NewDishViewController(viewModel: viewModel)
        navigationController?.pushViewController(newDishViewController, animated: false)
    }
}

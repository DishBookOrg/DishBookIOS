//
//  DishBookCoordinator.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 02.02.2021.
//

import UIKit

final class DishBookCoordinator: BaseRootCoordinator {
    
    override init() {
        super.init()
        
        self.tabItem = UITabBarItem(title: R.string.dishBook.dishBook(),
                                    image: R.image.dishBook(),
                                    selectedImage: R.image.dishBook()?.withTintColor(R.color.primaryOrangeMuted()!,
                                                                                     renderingMode: .alwaysOriginal))
        start()
    }
    
    override func start() {
        
        let viewModel = DishBookViewModel()
        let dishBookController = DishBookViewController(viewModel: viewModel)
        navigationController?.pushViewController(dishBookController, animated: false)
    }
}

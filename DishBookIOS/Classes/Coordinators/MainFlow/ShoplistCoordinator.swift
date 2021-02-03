//
//  ShoplistCoordinator.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 02.02.2021.
//

import UIKit

final class ShoplistCoordinator: BaseRootCoordinator {
    
    override init() {
        super.init()
        
        self.tabItem = UITabBarItem(title: R.string.shoplist.shoppingList(),
                                    image: R.image.shoppingList(),
                                    selectedImage: R.image.shoppingList()?.withTintColor(R.color.orangeMuted()!,
                                                                                         renderingMode: .alwaysOriginal))
        start()
    }
    
    override func start() {
        
        let viewModel = ShoplistViewModel()
        let shoplistViewController = ShoplistViewController.create(viewModel: viewModel)
        navigationController?.pushViewController(shoplistViewController, animated: false)
    }
}

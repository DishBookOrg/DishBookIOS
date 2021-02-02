//
//  ExploreCoordinator.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 30.01.2021.
//

import UIKit

final class ExploreCoordinator: BaseRootCoordinator {
    
    override init() {
        super.init()
        
        self.tabItem = UITabBarItem(title: R.string.explore.explore(),
                                    image: R.image.search(),
                                    selectedImage: R.image.search()?.withTintColor(R.color.orangeMuted()!,
                                                                                   renderingMode: .alwaysOriginal))
        start()
    }
    
    override func start() {
        
        let viewModel = ExploreViewModel()
        let exploreController = ExploreViewController.create(viewModel: viewModel)
        navigationController?.pushViewController(exploreController, animated: false)
    }
}

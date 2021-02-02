//
//  ProfileCoordinator.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 02.02.2021.
//

import UIKit

final class ProfileCoordinator: BaseRootCoordinator {
    
    override init() {
        super.init()
        
        self.tabItem = UITabBarItem(title: R.string.profile.profile(),
                                    image: R.image.profile(),
                                    selectedImage: R.image.profile()?.withTintColor(R.color.orangeMuted()!,
                                                                                    renderingMode: .alwaysOriginal))
        start()
    }
    
    override func start() {
        
        let viewModel = ProfileViewModel()
        let profileViewController = ProfileViewController.create(viewModel: viewModel)
        navigationController?.pushViewController(profileViewController, animated: false)
    }
}

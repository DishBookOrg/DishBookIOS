//
//  ProfileViewController.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 02.02.2021.
//

import UIKit

final class ProfileViewController: BaseViewController {

    // MARK: - Private properties
    
    private var viewModel: ProfileViewModel
    
    // MARK: - Lifecycle
    
    init?(coder: NSCoder, viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        
        super.init(coder: coder, closableCoordinator: viewModel)
    }
    
    static func create(viewModel: ProfileViewModel) -> ProfileViewController {
        
        return R.storyboard.profile().instantiateViewController(identifier: R.storyboard.profile.profileViewController.identifier) { coder in
            return ProfileViewController(coder: coder, viewModel: viewModel)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

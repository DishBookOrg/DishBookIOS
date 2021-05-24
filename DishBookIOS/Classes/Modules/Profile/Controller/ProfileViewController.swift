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
    private let logoutButton = UIButton()
    
    // MARK: - Lifecycle
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil, closableCoordinator: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLogoutButton()
    }
    
    // MARK: - Setup methods
    
    private func setupLogoutButton() {
        
        view.addSubview(logoutButton, constraints: [
            
            logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
            logoutButton.widthAnchor.constraint(equalToConstant: 130)
        ])
        
        logoutButton.backgroundColor = R.color.primaryRed()
        logoutButton.apply(style: Styles.View.CornerRadius.small)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(R.color.textWhite(), for: .normal)
        
        logoutButton
            .publisher(for: .touchUpInside)
            .sink { _ in
                App.logout()
            }
            .store(in: &cancelableSet)
    }
}

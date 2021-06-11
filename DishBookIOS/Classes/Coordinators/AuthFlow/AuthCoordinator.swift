//
//  AuthCoordinator.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 30.01.2021.
//

import UIKit

final class AuthCoordinator: BaseCoordinator {
    
    weak var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController?) {
        
        self.navigationController = navigationController
        self.navigationController.isNavigationBarHidden = true
    }
    
    override func start() {
        
        let viewModel = LoginViewModel()
        let loginController = LoginViewController.create(viewModel: viewModel)
        
        let signInWithAppleCoordinator = SignInWithAppleCoordinator()
//        let signInWithGoogleCoordinator = SignInWithGoogleCoordinator()

        viewModel.googleAuthAction = {
//            signInWithGoogleCoordinator.startSignIn { [weak self] in
//                self?.isCompleted?()
//            }
        }
        viewModel.appleAuthAction = {
            signInWithAppleCoordinator.startSignInWithAppleFlow(authControllerDelegate: loginController) { nonce in
                viewModel.currentNonce = nonce
            }
        }
        viewModel.didLogin = { [weak self] in
            self?.isCompleted?()
        }
        
        navigationController?.pushViewController(loginController, animated: false)
    }
}

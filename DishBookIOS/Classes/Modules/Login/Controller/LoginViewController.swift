//
//  LoginViewController.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 30.01.2021.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import AuthenticationServices
import CryptoKit

final class LoginViewController: BaseViewController {
    
    // MARK: - Private properties
    
    private var viewModel: LoginViewModel
    
    // MARK: - Lifecycle
    
    init?(coder: NSCoder, viewModel: LoginViewModel) {
        self.viewModel = viewModel
        
        super.init(coder: coder, closableCoordinator: viewModel)
    }
    
    static func create(viewModel: LoginViewModel) -> LoginViewController {
        
        return R.storyboard.login().instantiateViewController(identifier: R.storyboard.login.loginViewController.identifier) { coder in
            return LoginViewController(coder: coder, viewModel: viewModel)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - IBActions
    
    @IBAction func appleAuthAction(_ sender: Any) {
        
        viewModel.appleAuthAction?()
    }
    
    @IBAction func googleAuthAction(_ sender: Any) {
        
        viewModel.googleAuthAction?()
    }
}

// MARK: - ASAuthorizationControllerDelegate

@available(iOS 13.0, *)
extension LoginViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = viewModel.currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            Auth.auth().signIn(with: credential) { [weak self] authResult, error in
                if error != nil {
                    
                    print(error?.localizedDescription ?? "")
                    return
                }
                
                App.user = authResult?.user
                self?.viewModel.didLogin?()
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
        print("Sign in with Apple errored: \(error)")
    }
}

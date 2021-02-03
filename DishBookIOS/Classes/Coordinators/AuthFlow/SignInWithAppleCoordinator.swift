//
//  SignInWithAppleCoordinator.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 30.01.2021.
//

import Foundation
import Firebase
import AuthenticationServices
import FirebaseAuth
import CryptoKit

final class SignInWithAppleCoordinator: NSObject, ASAuthorizationControllerPresentationContextProviding {
    
    // MARK: - Private properties
    
    // Unhashed nonce.
    fileprivate var currentNonce: String?
    
    // MARK: - SignIn Flow
    
    @available(iOS 13, *)
    func startSignInWithAppleFlow(authControllerDelegate: ASAuthorizationControllerDelegate,
                                  didCreateNonce: @escaping (String) -> Void) {
        
        let nonce = randomNonceString()
        currentNonce = nonce
        didCreateNonce(nonce)
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = authControllerDelegate
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        
        return UIApplication.shared.windows.first!
    }
}

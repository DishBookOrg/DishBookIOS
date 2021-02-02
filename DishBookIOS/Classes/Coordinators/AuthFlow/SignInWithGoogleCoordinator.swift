//
//  SignInWithGoogleCoordinator.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 02.02.2021.
//

import GoogleSignIn
import Firebase
import FirebaseAuth

final class SignInWithGoogleCoordinator: NSObject, GIDSignInDelegate, ObservableObject {
        
    private var signInCompletion: VoidClosure?
    
    func startSignIn(signInCompletion: @escaping () -> Void) {
        
        self.signInCompletion = signInCompletion
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().presentingViewController = UIApplication.topViewController()!
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let authentication = user.authentication else {
            return
        }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            App.user = authResult?.user
            self?.signInCompletion?()
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
}

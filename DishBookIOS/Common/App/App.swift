//
//  App.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 30.01.2021.
//

import Foundation
import IQKeyboardManagerSwift
import Firebase
import FirebaseAuth

import Wormholy
import SDWebImage

struct App {

    static var user: User?
    static var appCoordinator: AppCoordinator!
    
    static func setup() {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.disabledDistanceHandlingClasses = []
        IQKeyboardManager.shared.disabledToolbarClasses = []
        
        Wormholy.shakeEnabled = false
        FirebaseApp.configure()

        user = Auth.auth().currentUser
        
        print("Setup complete")
    }
    
    static func startCoordinator(in window: UIWindow) {
        
        let appCoordinator = AppCoordinator(window: window)
        self.appCoordinator = appCoordinator
        appCoordinator.start()
    }
    
    static func logout() {
        
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
        user = nil
        appCoordinator.logout()
    }
}

func IMPLEMENT_ME(TODO: String? = nil, file: String = #file, line: Int = #line) {
    
    print("\n⚠️⚠️⚠️ IMPLEMENT ME \(TODO ?? "")\n\(file) \(line)\n")
}

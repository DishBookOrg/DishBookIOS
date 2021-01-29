//
//  AppDelegate.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 29.01.2021.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
        FirebaseApp.configure()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let controller = R.storyboard.main.instantiateInitialViewController()!
        window.rootViewController = controller
        window.makeKeyAndVisible()
        
        return true
    }
}

//
//  AppDelegate.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 29.01.2021.
//

import UIKit
//import GoogleSignIn

#if DEBUG
import Gedatsu
#endif

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        #if DEBUG
        Gedatsu.open()
        #endif
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        App.setup()
        App.startCoordinator(in: window)
        
        return true
    }

//
//    @available(iOS 9.0, *)
//    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
//        return GIDSignIn.sharedInstance().handle(url)
//    }
}

//
//  ViewStyles.swift
//  DishBookIOS
//
//  Created by Anastasia Holovash on 04.05.2021.
//

import UIKit
import StyleableUI

extension Styles {
    
    struct View { }
}

// MARK: - Corner radius

extension Styles.View {
    
    static var smallCornerRadius: Style<UIView> = { view in
        
        view.layer.cornerRadius = 20
//        view.layer.sublayers?.forEach { $0.cornerRadius = 20 }
    }
}

// MARK: - Shadows

extension Styles.View {
    
    static var blackShadow1: Style<UIView> = { view in
        
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shadowRadius = 16
        view.layer.shadowOffset = .init(width: 0, height: 16)
        view.layer.shadowOpacity = 0.08
        view.layer.shadowColor = UIColor(red: 50/255, green: 50/255, blue: 71/255, alpha: 1.0).cgColor
    }
    
    static var blackShadow2: Style<UIView> = { view in
        
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shadowRadius = 32
        view.layer.shadowOffset = .init(width: 0, height: 24)
        view.layer.shadowOpacity = 0.08
        view.layer.shadowColor = UIColor(red: 50/255, green: 50/255, blue: 71/255, alpha: 1.0).cgColor
    }
    
    static var shadow16: Style<UIView> = { view in
        
        view.apply(styles: blackShadow1, blackShadow2)
    }
    
    static var testRedShadow: Style<UIView> = { view in
        
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shadowRadius = 16
        view.layer.shadowOffset = .init(width: 0, height: 0)
        view.layer.shadowOpacity = 0.6
        view.layer.shadowColor = UIColor.red.cgColor
    }
}

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
    
    static var cornerRadius20: Style<UIView> = { view in
        
        view.layer.cornerRadius = 20
        view.layer.sublayers?.forEach { $0.cornerRadius = 20 }
    }
    
    static var cornerRadius10: Style<UIView> = { view in
        
        view.layer.cornerRadius = 10
        view.layer.sublayers?.forEach { $0.cornerRadius = 10 }
    }
    
    static var cornerRadius0: Style<UIView> = { view in
        
        view.layer.cornerRadius = 0
        view.layer.sublayers?.forEach { $0.cornerRadius = 0 }
    }
    
    static var maskedLeftCorners: Style<UIView> = { view in
        
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        view.layer.sublayers?.forEach {
            $0.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
    }
    
    static var maskedRightCorners: Style<UIView> = { view in
        
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        view.layer.sublayers?.forEach {
            $0.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        }
    }
    
    static var noMaskedCorners: Style<UIView> = { view in
        
        view.layer.maskedCorners = []
        view.layer.sublayers?.forEach {
            $0.maskedCorners = []
        }
    }
}

// MARK: - Gradient

extension Styles.View {
    
    static var mainGradient: Style<UIView> = { view in
        
        if let gradientLayer = view.layer.sublayers?.first(where: { $0 is CAGradientLayer }) as? CAGradientLayer {
            
            gradientLayer.frame = view.bounds
        } else {
            let gradient = CAGradientLayer()
            gradient.type = .axial
            gradient.startPoint = CGPoint(x: -1, y: 1)
            gradient.endPoint = CGPoint(x: 1, y: -1)
            gradient.locations = [0, 1]
            
            gradient.colors = [
                UIColor(red: 254 / 255, green: 203 / 255, blue: 24 / 255, alpha: 1.0).cgColor,
                UIColor(red: 250 / 255, green: 112 / 255, blue: 11 / 255, alpha: 1.0).cgColor
            ]
            
            gradient.frame = view.bounds
            
            view.layer.insertSublayer(gradient, at: 0)
        }
    }
    
    static var mutedGradient: Style<UIView> = { view in
        
        if let gradientLayer = view.layer.sublayers?.first(where: { $0 is CAGradientLayer }) as? CAGradientLayer {
            
            gradientLayer.frame = view.bounds
        } else {
            let gradient = CAGradientLayer()
            gradient.type = .axial
            gradient.startPoint = CGPoint(x: -1, y: 1)
            gradient.endPoint = CGPoint(x: 1, y: -1)
            gradient.locations = [0, 1]
            
            gradient.colors = [
                UIColor(red: 208 / 255, green: 164 / 255, blue: 49 / 255, alpha: 1.0).cgColor,
                UIColor(red: 236 / 255, green: 124 / 255, blue: 21 / 255, alpha: 1.0).cgColor
            ]
            
            gradient.frame = view.bounds
            
            view.layer.insertSublayer(gradient, at: 0)
        }
    }
}

// MARK: - Shadows

extension Styles.View {
    
    static var cardShadow16: Style<UIView> = { view in
        
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shadowRadius = 32
        view.layer.shadowOffset = .init(width: 0, height: 24)
        view.layer.shadowOpacity = 0.16
        view.layer.shadowColor = UIColor(red: 50 / 255, green: 50 / 255, blue: 71 / 255, alpha: 1.0).cgColor
    }
    
    static var cardShadow20: Style<UIView> = { view in
        
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shadowRadius = 40
        view.layer.shadowOffset = .init(width: 0, height: 32)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowColor = UIColor(red: 50 / 255, green: 50 / 255, blue: 71 / 255, alpha: 1.0).cgColor
    }

    static var cardShadow24: Style<UIView> = { view in
        
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shadowRadius = 48
        view.layer.shadowOffset = .init(width: 0, height: 40)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowColor = UIColor(red: 50 / 255, green: 50 / 255, blue: 71 / 255, alpha: 1.0).cgColor
    }
}

//
//  Gradient+View.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 24.05.2021.
//

import UIKit
import StyleableUI

extension Styles.View {
    
    struct Gradient { }
}

extension Styles.View.Gradient {
    
    static var main: StyleGet<UIView, CAGradientLayer> = { view in
        
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
        return gradient
    }
    
    static var muted: StyleGet<UIView, CAGradientLayer> = { view in
        
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
        return gradient
    }
}

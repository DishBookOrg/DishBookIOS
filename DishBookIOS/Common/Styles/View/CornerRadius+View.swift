//
//  CornerRadius+View.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 24.05.2021.
//

import UIKit
import StyleableUI

extension Styles.View {
    
    struct CornerRadius { }
}

extension Styles.View.CornerRadius {
    
    static var small: Style<UIView> = { view in
        
        view.layer.cornerRadius = 20
        view.layer.sublayers?.forEach { $0.cornerRadius = 20 }
    }
    
    static var d17: Style<UIView> = { view in
        
        view.layer.cornerRadius = 17
        view.layer.sublayers?.forEach { $0.cornerRadius = 17 }
    }
    
    static var d10: Style<UIView> = { view in
        
        view.layer.cornerRadius = 10
        view.layer.sublayers?.forEach { $0.cornerRadius = 10 }
    }
    
    static var d3: Style<UIView> = { view in
        
        view.layer.cornerRadius = 3
        view.layer.sublayers?.forEach { $0.cornerRadius = 3 }
    }
    
    static var d0: Style<UIView> = { view in
        
        view.layer.cornerRadius = 0
        view.layer.sublayers?.forEach { $0.cornerRadius = 0 }
    }
    
    static var maskedRight: Style<UIView> = { view in
        
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        view.layer.sublayers?.forEach {
            $0.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        }
    }
    
    static var maskedLeft: Style<UIView> = { view in
        
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        view.layer.sublayers?.forEach {
            $0.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
    }
    
    static var noMasked: Style<UIView> = { view in
        
        view.layer.maskedCorners = []
        view.layer.sublayers?.forEach {
            $0.maskedCorners = []
        }
    }
}

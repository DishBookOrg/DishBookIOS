//
//  Shadow+View.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 24.05.2021.
//

import UIKit
import StyleableUI

extension Styles.View {
    
    struct Shadow { }
}

/// d is deep
extension Styles.View.Shadow {
    
    static var d16: Style<UIView> = { view in
        
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shadowRadius = 32
        view.layer.shadowOffset = .init(width: 0, height: 24)
        view.layer.shadowOpacity = 0.16
        view.layer.shadowColor = UIColor(red: 50 / 255, green: 50 / 255, blue: 71 / 255, alpha: 1.0).cgColor
    }
    
    static var d20: Style<UIView> = { view in
        
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shadowRadius = 40
        view.layer.shadowOffset = .init(width: 0, height: 32)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowColor = UIColor(red: 50 / 255, green: 50 / 255, blue: 71 / 255, alpha: 1.0).cgColor
    }
    
    static var d24: Style<UIView> = { view in
        
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shadowRadius = 48
        view.layer.shadowOffset = .init(width: 0, height: 40)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowColor = UIColor(red: 50 / 255, green: 50 / 255, blue: 71 / 255, alpha: 1.0).cgColor
    }
}

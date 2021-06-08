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
}

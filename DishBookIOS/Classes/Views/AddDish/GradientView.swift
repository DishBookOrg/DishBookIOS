//
//  GradientView.swift
//  DishBookIOS
//
//  Created by Anastasia Holovash on 16.06.2021.
//

import UIKit

final class GradientView: UIView {
    
    override func draw(_ rect: CGRect) {
        
        apply(style: Styles.View.Gradient.muted)
        apply(style: Styles.View.CornerRadius.small)
    }
}

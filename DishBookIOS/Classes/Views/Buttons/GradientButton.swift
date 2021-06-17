//
//  GradientButton.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 16.06.2021.
//

import UIKit

class GradientButton: UIButton {
    
    override func draw(_ rect: CGRect) {
        
        apply(style: Styles.View.Gradient.muted)
        apply(style: Styles.View.CornerRadius.small)
        apply(style: Styles.View.Shadow.d20)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel?.apply(style: Styles.Font.Rounded.SB.f3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  BlackButton.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 16.06.2021.
//

import UIKit

class BlackButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = R.color.markedLight()
        clipsToBounds = true
        apply(style: Styles.View.CornerRadius.small)
        titleLabel?.apply(style: Styles.Font.Rounded.SB.f2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

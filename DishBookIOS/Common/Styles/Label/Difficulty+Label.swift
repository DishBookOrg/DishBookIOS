//
//  Difficulty+Label.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 24.05.2021.
//

import UIKit
import StyleableUI

extension Styles.Label {
    
    struct Difficulty { }
}

extension Styles.Label.Difficulty {
    
    static var easy: Style<UILabel> = { label in
        
        label.font = R.font.sfProRoundedSemibold(size: 16)
        label.textAlignment = .center
        label.textColor = R.color.primaryGreen()
    }
}

//
//  LabelStyles.swift
//  DishBookIOS
//
//  Created by Anastasia Holovash on 04.05.2021.
//

import UIKit
import StyleableUI

extension Styles {
    
    struct Label { }
}

extension Styles.Label {
    
    static var roundedSB2: Style<UILabel> = { label in
        
        label.font = R.font.sfProRoundedSemibold(size: 30)
        label.numberOfLines = 0
        label.textColor = .white
    }
}

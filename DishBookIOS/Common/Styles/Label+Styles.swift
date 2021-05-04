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

    static var easyDifficult: Style<UILabel> = { label in
        
        label.apply(style: roundedSB5)
        label.textAlignment = .center
        label.textColor = R.color.primaryGreen()
    }
}

extension Styles.Label {
    
    static var roundedSB2: Style<UILabel> = { label in
        
        label.font = R.font.sfProRoundedSemibold(size: 30)
        label.numberOfLines = 0
        label.textColor = .white
    }
    
    static var roundedSB4: Style<UILabel> = { label in
        
        label.font = R.font.sfProRoundedSemibold(size: 20)
        label.numberOfLines = 0
    }
    
    static var roundedSB5: Style<UILabel> = { label in
        
        label.font = R.font.sfProRoundedSemibold(size: 16)
        label.numberOfLines = 0
    }
    
    static var roundedRegular6: Style<UILabel> = { label in
        
        // TODO: Add another font
        label.font = R.font.sfProRoundedMedium(size: 14)
        label.numberOfLines = 0
    }
}

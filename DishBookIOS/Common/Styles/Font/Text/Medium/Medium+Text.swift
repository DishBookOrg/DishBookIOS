//
//  Medium+Text.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 24.05.2021.
//

import UIKit
import StyleableUI

extension Styles.Font.Text {
    
    struct Medium { }
}

extension Styles.Font.Text.Medium {
    
    static var f1: Style<UILabel> = { label in
        
        label.font = R.font.sfProTextMedium(size: 34)
    }
    
    static var f2: Style<UILabel> = { label in
        
        label.font = R.font.sfProTextMedium(size: 28)
    }
    
    static var f3: Style<UILabel> = { label in
        
        label.font = R.font.sfProTextMedium(size: 22)
    }
    
    static var f4: Style<UILabel> = { label in
        
        label.font = R.font.sfProTextMedium(size: 20)
    }
    
    static var f5: Style<UILabel> = { label in
        
        label.font = R.font.sfProTextMedium(size: 17)
    }
    
    static var f6: Style<UILabel> = { label in
        
        label.font = R.font.sfProTextMedium(size: 15)
    }
}

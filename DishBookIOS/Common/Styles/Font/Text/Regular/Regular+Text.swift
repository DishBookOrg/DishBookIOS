//
//  Regular+Text.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 24.05.2021.
//

import UIKit
import StyleableUI

extension Styles.Font.Text {
    
    struct Regular { }
}

extension Styles.Font.Text.Regular {
    
    static var f1: Style<UILabel> = { label in
        
        label.font = R.font.sfProTextRegular(size: 34)
    }
    
    static var f2: Style<UILabel> = { label in
        
        label.font = R.font.sfProTextRegular(size: 28)
    }
    
    static var f3: Style<UILabel> = { label in
        
        label.font = R.font.sfProTextRegular(size: 22)
    }
    
    static var f4: Style<UILabel> = { label in
        
        label.font = R.font.sfProTextRegular(size: 20)
    }
    
    static var f5: Style<UILabel> = { label in
        
        label.font = R.font.sfProTextRegular(size: 17)
    }
    
    static var f6: Style<UILabel> = { label in
        
        label.font = R.font.sfProTextRegular(size: 15)
    }
}

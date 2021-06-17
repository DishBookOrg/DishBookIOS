//
//  SB+Text.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 24.05.2021.
//

import UIKit
import StyleableUI

extension Styles.Font.Text {
    
    struct SB { }
}

extension Styles.Font.Text.SB {
    
    static var f1: Style<UILabel> = { label in
        
        label.font = R.font.sfProTextSemibold(size: 34)
    }
    
    static var f2: Style<UILabel> = { label in
        
        label.font = R.font.sfProTextSemibold(size: 28)
    }
    
    static var f3: Style<UILabel> = { label in
        
        label.font = R.font.sfProTextSemibold(size: 22)
    }
    
    static var f4: Style<UILabel> = { label in
        
        label.font = R.font.sfProTextSemibold(size: 20)
    }
    
    static var f5: Style<UILabel> = { label in
        
        label.font = R.font.sfProTextSemibold(size: 17)
    }
    
    static var f6: Style<UILabel> = { label in
        
        label.font = R.font.sfProTextSemibold(size: 15)
    }
}

//
//  Regular+Rounded.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 24.05.2021.
//

import UIKit
import StyleableUI

extension Styles.Font.Rounded {
    
    struct Regular { }
}

// TODO: Change to Regular instead of Medium
extension Styles.Font.Rounded.Regular {
    
    static var f1: Style<UILabel> = { label in
        
        label.font = R.font.sfProRoundedMedium(size: 34)
    }
    
    static var f2: Style<UILabel> = { label in
        
        label.font = R.font.sfProRoundedMedium(size: 28)
    }
    
    static var f3: Style<UILabel> = { label in
        
        label.font = R.font.sfProRoundedMedium(size: 22)
    }
    
    static var f4: Style<UILabel> = { label in
        
        label.font = R.font.sfProRoundedMedium(size: 20)
    }
    
    static var f5: Style<UILabel> = { label in
        
        label.font = R.font.sfProRoundedMedium(size: 17)
    }
    
    static var f6: Style<UILabel> = { label in
        
        label.font = R.font.sfProRoundedMedium(size: 15)
    }
}

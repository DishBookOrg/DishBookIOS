//
//  DescriptionUILabel.swift
//  DishBookIOS
//
//  Created by Anastasia Holovash on 09.03.2021.
//

import UIKit

final class DescriptionUILabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        font = R.font.sfProRoundedMedium(size: 12)
        textColor = R.color.textDescriptionGray()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  DescriptionUILabel.swift
//  DishBookIOS
//
//  Created by Anastasia Holovash on 09.03.2021.
//

import UIKit

final class DescriptionUILabel: UILabel {
        
    override func layoutSubviews() {
        
        font = R.font.sfProRoundedMedium(size: 12)
        textColor = R.color.textDescriptionGray()
    }
}

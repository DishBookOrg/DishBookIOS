//
//  SectionHeader.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 10.05.2021.
//


import UIKit

final class SectionHeader: UICollectionReusableView {
    
    static let reuseIdentifier = "SectionHeader"
    
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.textColor = .label
        titleLabel.font = R.font.sfProRoundedSemibold(size: 30)
        
        addSubview(titleLabel, constraints: [
            titleLabel.heightAnchor.constraint(equalToConstant: 34),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Stop trying to make storyboards happen.")
    }
}

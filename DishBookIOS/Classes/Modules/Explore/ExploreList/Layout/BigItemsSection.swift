//
//  BigItemsSection.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 04.05.2021.
//

import UIKit

struct BigItemsSection: CollectionSection {
    
    var numberOfItems: Int = 5
    
    func layoutSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                             heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
//        let screenWidth = UIScreen.main.bounds.width
//        let size = (screenWidth - 40) / screenWidth
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                          heightDimension: .absolute(400)),
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        section.contentInsets = .init(top: 10, leading: 10, bottom: 25, trailing: 10)
        return section
    }
}

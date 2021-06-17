//
//  SearchSection.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 18.06.2021.
//

import UIKit

struct SearchSection: CollectionSection {
    
    func layoutSection(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                             heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                          heightDimension: .estimated(400)),
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        return section
    }
}

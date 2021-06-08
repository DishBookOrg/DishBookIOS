//
//  SmallItemsSection.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 04.05.2021.
//

import UIKit

struct SmallItemsSection: CollectionSection {
    
    var numberOfItems: Int
    
    func layoutSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(190),
                                                                             heightDimension: .absolute(250)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(190),
                                               heightDimension: .absolute(250))
        
        let containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: containerGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 25, trailing: 10)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        let layoutSectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [layoutSectionHeader]
        return section
    }
}

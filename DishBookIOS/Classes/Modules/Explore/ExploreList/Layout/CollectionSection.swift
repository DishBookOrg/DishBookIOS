//
//  Section.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 04.05.2021.
//

import UIKit

protocol CollectionSection: Hashable {
    
    var numberOfItems: Int { get }
    
    func layoutSection() -> NSCollectionLayoutSection
//    func createSectionHeader() -> NSCollectionLayoutSupplementaryItem
}

// MARK: - Implementation

extension CollectionSection {
    
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(47))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize,
                                                                              elementKind: UICollectionView.elementKindSectionHeader,
                                                                              alignment: .top)
        return layoutSectionHeader
    }
}

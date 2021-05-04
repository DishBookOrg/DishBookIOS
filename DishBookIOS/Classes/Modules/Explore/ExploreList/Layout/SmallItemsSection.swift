//
//  SmallItemsSection.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 04.05.2021.
//

import UIKit

struct SmallItemsSection: Section {
    
    var numberOfItems: Int = 10
    
    func layoutSection() -> NSCollectionLayoutSection {
                
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(210),
                                                                             heightDimension: .absolute(260)))

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(210),
                                               heightDimension: .absolute(260))
        
        let containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: containerGroup)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        return section
    }
    
    func configureCell(collectionView: UICollectionView,
                       indexPath: IndexPath,
                       data: Dish) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.dishCardSmallCollectionViewCell, for: indexPath) else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: data)
        return cell
    }
}

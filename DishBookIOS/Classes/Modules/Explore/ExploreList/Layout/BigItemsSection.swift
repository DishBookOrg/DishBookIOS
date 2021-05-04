//
//  BigItemsSection.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 04.05.2021.
//

import UIKit

struct BigItemsSection: Section {
    
    var numberOfItems: Int = 5
    
    func layoutSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                             heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92),
                                                                                          heightDimension: .absolute(400)),
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        return section
    }
    
    func configureCell(collectionView: UICollectionView,
                       indexPath: IndexPath,
                       data: Dish) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.dishCardBigCollectionViewCell,
                                                            for: indexPath) else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: data)
        return cell
    }
}

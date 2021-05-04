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
//    func configureCell(collectionView: UICollectionView, indexPath: IndexPath, data: Dish) -> UICollectionViewCell
//    func cellRegistration() -> UICollectionView.CellRegistration<UICollectionViewCell, Dish>
}

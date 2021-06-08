//
//  BindableCell.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 04.05.2021.
//

import UIKit

protocol Bindable {
    
    associatedtype Props
    
    func render(props: Props)
}

protocol BindableCell: Bindable & ReusableCell { }

extension BindableCell {
    
    static func cellProvider(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        props: Props
    ) -> UICollectionViewCell? where Self: UICollectionViewCell {
        let cell: Self = collectionView.dequeueReusableCell(forItemAt: indexPath)
        cell.render(props: props)
        return cell
    }
    
    static func cellProvider(
        tableView: UITableView,
        indexPath: IndexPath,
        props: Props
    ) -> UITableViewCell? where Self: UITableViewCell {
        let cell: Self = tableView.dequeueReusableCell(forItemAt: indexPath)
        cell.render(props: props)
        return cell
    }
}

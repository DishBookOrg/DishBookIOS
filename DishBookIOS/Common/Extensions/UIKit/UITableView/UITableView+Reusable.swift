//
//  UITableView+Reusable.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 04.05.2021.
//

import UIKit

extension UITableView {
    
    func dequeueReusableCell<CellType: UITableViewCell & ReusableCell>(
        forItemAt indexPath: IndexPath,
        cellType: CellType.Type = CellType.self
    ) -> CellType {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? CellType else {
            fatalError("Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self).")
        }
        
        return cell
    }
    
    func register<CellType: UITableViewCell & ReusableCell>(_ cellType: CellType.Type) {
        register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    func register<ViewType: UITableViewHeaderFooterView & ReusableCell>(_ headerFooter: ViewType.Type) {
        register(headerFooter.self, forHeaderFooterViewReuseIdentifier: headerFooter.reuseIdentifier)
    }
}

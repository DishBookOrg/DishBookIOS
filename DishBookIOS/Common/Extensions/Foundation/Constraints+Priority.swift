//
//  Constraints+Priority.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 17.06.2021.
//

import UIKit

extension NSLayoutConstraint {
    
    @discardableResult
    func prioritised(as priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}

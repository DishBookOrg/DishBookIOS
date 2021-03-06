//
//  Publisher+AssignNoRetain.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 03.02.2021.
//

import Foundation
import Combine

extension Publisher where Self.Failure == Never {
    
    public func assignNoRetain<Root>(to keyPath: ReferenceWritableKeyPath<Root, Self.Output>, on object: Root) -> AnyCancellable where Root: AnyObject {
        sink { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }
}

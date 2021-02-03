//
//  UITextField+Publisher.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 03.02.2021.
//

import UIKit
import Combine

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap {
                $0.object as? UITextField
            }
            .map {
                $0.text ?? ""
            }
            .eraseToAnyPublisher()
    }
}

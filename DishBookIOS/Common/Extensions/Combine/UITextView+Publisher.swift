//
//  UITextView+Publisher.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 03.02.2021.
//

import UIKit
import Combine

extension UITextView {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextView.textDidChangeNotification, object: self)
            .compactMap {
                $0.object as? UITextView
            }
            .map {
                $0.text ?? ""
            }
            .eraseToAnyPublisher()
    }
}

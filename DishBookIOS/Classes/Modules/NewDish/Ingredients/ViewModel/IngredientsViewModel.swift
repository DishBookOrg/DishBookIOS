//
//  IngredientsViewModel.swift
//  DishBookIOS
//
//  Created by Anastasia Holovash on 14.06.2021.
//

import Foundation
import Combine

final class IngredientsViewModel: BaseViewModel {
    
    // MARK: - Publishers
    
    lazy var didPressNextPublisher = didPressNextSubject.eraseToAnyPublisher()
    lazy var didPressPlusPublisher = didPressPlusSubject.eraseToAnyPublisher()
    
    
    // MARK: - Subjects

    let didPressNextSubject = PassthroughSubject<Void, Never>()
    let didPressPlusSubject = PassthroughSubject<Void, Never>()
}

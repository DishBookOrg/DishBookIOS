//
//  NewDishViewModel.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 02.02.2021.
//

import Foundation
import Combine

final class FirstStepViewModel: BaseViewModel {
    
    // MARK: - Publishers
    
    lazy var didSelectPrivacyLevelPublisher = didSelectPrivacyLevelSubject.eraseToAnyPublisher()
    lazy var didSelectDifficultyLevelPublisher = didSelectDifficultyLevelSubject.eraseToAnyPublisher()
    lazy var didChangeNamePublisher = didChangeNameSubject.eraseToAnyPublisher()
    lazy var didChangeNumberOfServingsPublisher = didChangeNumberOfServingsSubject.eraseToAnyPublisher()
    lazy var didPressNextPublisher = didPressNextSubject.eraseToAnyPublisher()
    
    // MARK: - Subjects
    
    let didSelectPrivacyLevelSubject = PassthroughSubject<Dish.Privacy, Never>()
    let didSelectDifficultyLevelSubject = PassthroughSubject<Dish.Difficulty, Never>()
    let didChangeNameSubject = PassthroughSubject<String, Never>()
    let didChangeNumberOfServingsSubject = PassthroughSubject<Int, Never>()
    let didPressNextSubject = PassthroughSubject<Void, Never>()
    
    var onNext: VoidClosure?
}

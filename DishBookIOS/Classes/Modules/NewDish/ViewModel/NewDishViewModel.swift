//
//  NewDishViewModel.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 02.02.2021.
//

import Foundation
import Combine

final class NewDishViewModel: BaseViewModel {
    
    // Publishers
    lazy var didSelectPublisher = didSelectPrivacyLevelSubject.eraseToAnyPublisher()
    lazy var didSelectDifficultyLevelPublisher = didSelectDifficultyLevelSubject.eraseToAnyPublisher()
    lazy var didChangeNamePublisher = didChangeNameSubject.eraseToAnyPublisher()
    lazy var didChangeNumberOfServingsPublisher = didChangeNumberOfServingsSubject.eraseToAnyPublisher()
    lazy var didPressNextPublisher = didPressNextSubject.eraseToAnyPublisher()
    
    // Subjects
    private let didSelectPrivacyLevelSubject = PassthroughSubject<PrivacyLevel, Never>()
    private let didSelectDifficultyLevelSubject = PassthroughSubject<DifficultyLevel, Never>()
    private let didChangeNameSubject = PassthroughSubject<String, Never>()
    private let didChangeNumberOfServingsSubject = PassthroughSubject<Int, Never>()
    private let didPressNextSubject = PassthroughSubject<Int, Never>()
    
    
    enum PrivacyLevel {
        case own
        case `public`
        
        var stringValue: String {
            switch self {
            case .own:
                return R.string.newDish.segmentedControlPrivate()
            case .public: return R.string.newDish.segmentedControlPublic()
            }
        }
    }
    
    enum DifficultyLevel {
        case easy
        case medium
        case hard
        
        var stringValue: String {
            switch self {
            case .easy: return R.string.newDish.segmentedControlDifficultyEasy()
            case .medium: return R.string.newDish.segmentedControlDifficultyMedium()
            case .hard: return R.string.newDish.segmentedControlDifficultyHard()
            }
        }
    }
}

//
//  NewIngredientViewModel.swift
//  DishBookIOS
//
//  Created by Anastasia Holovash on 16.06.2021.
//

import Foundation
import Combine

final class NewIngredientViewModel: BaseViewModel {
    
    // MARK: - Publishers
    
    lazy var didPressDonePublisher = didPressDoneSubject.eraseToAnyPublisher()
    lazy var didPressBackPublisher = didPressBackSubject.eraseToAnyPublisher()
    
    // MARK: - Subjects

    let didPressDoneSubject = PassthroughSubject<IngredientsAndSteps.Ingredient, Never>()
    let didPressBackSubject = PassthroughSubject<Void, Never>()
}

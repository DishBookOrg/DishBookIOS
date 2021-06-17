//
//  DishDetailViewModel.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 14.06.2021.
//

import UIKit
import Combine

final class DishDetailViewModel: BaseViewModel {
    
    enum DishDetailsType {
        case explore
        case newDish
        case dishBook
    }
    
    // MARK: - Published properties
    
    @Published var dish: Dish
    
    lazy var didPressPublicatePublisher = didPressPublicateSubject.eraseToAnyPublisher()
    let didPressPublicateSubject = PassthroughSubject<Void, Never>()
    
    let type: DishDetailsType
    
    // MARK: - Lifecycle
    
    init(dish: Dish, type: DishDetailsType) {
        self.dish = dish
        self.type = type
        
        super.init()
        
        if dish.ingredientsAndSteps == nil {
            getFullDish()
        }
    }
    
    func countNewIngredients(numberOfServings: Int) -> [SingleIngredientView.Props]? {
        
        guard let ingredientsAndSteps = dish.ingredientsAndSteps else {
            return nil
        }
        
        let value = Float(numberOfServings) / Float(dish.numberOfServings)
        let newIngredients = ingredientsAndSteps
            .ingredients
            .map { ingredient -> IngredientsAndSteps.Ingredient in
                var newIngredient = ingredient
                newIngredient.ingredientAmount = round(ingredient.ingredientAmount * value * 100) / 100.0
                return newIngredient
            }
        
        let singleIngredientViewProps = newIngredients
            .map {
                SingleIngredientView.Props(name: $0.ingredientName,
                                           amount: "\($0.ingredientAmount) \($0.ingredientType)")
            }
        return singleIngredientViewProps
    }
}

// MARK: - API

extension DishDetailViewModel {
    
    func getFullDish() {
        
        guard let dishId = dish.id else {
            return
        }
        
        APIClient
            .shared
            .collection(for: .publicDishes)
            .document(dishId)
            .collection("IngredientsAndSteps")
            .document("IngredientsAndSteps")
            .publisher(as: IngredientsAndSteps.self)
            .dropFirst()
            .sink { completion in
                print(completion)
            } receiveValue: { [unowned self] value in
                dish.ingredientsAndSteps = value
            }
            .store(in: &cancelableSet)
        
    }
}

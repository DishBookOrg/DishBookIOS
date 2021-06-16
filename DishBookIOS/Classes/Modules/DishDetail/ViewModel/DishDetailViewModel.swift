//
//  DishDetailViewModel.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 14.06.2021.
//

import UIKit

final class DishDetailViewModel: BaseViewModel {
    
    // MARK: - Published properties
    
    @Published var dish: Dish
    
    // MARK: - Lifecycle
    
    init(dish: Dish) {
        self.dish = dish
        
        super.init()
        
        getFullDish()
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
//            .getDocument(as: IngredientsAndSteps.self)
            .sink { completion in
                print(completion)
            } receiveValue: { [unowned self] value in
                print(value)
                dish.ingredientsAndSteps = value
            }
            .store(in: &cancelableSet)

    }
}

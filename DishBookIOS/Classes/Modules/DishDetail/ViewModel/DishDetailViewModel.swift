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
    }
}

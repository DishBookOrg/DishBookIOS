//
//  IngredientsAndSteps.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 16.06.2021.
//

import UIKit

struct IngredientsAndSteps: Codable {
    
    var ingredients: [Ingredient]
    var steps: [Step]
    
    struct Ingredient: Codable, Hashable {
        
        var ingredientName: String
        var ingredientType: String
        var ingredientAmount: Float
    }
    
    struct Step: Codable, Hashable {
        
        var stepDescription: String
        var stepAttachmentURL: String
        
        /// Time in seconds
        var stepTime: Int
    }
}

extension IngredientsAndSteps: Hashable {
    
}

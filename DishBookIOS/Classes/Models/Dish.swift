//
//  Dish.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 05.02.2021.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Dish {
    
    @DocumentID var id: String?
    var name: String
    var totalTime: Int
    var imageURL: String
    var ration: DishRation
    
    //
    var blockId: Int?
    
    static var mock: Dish = Dish(id: UUID().uuidString, name: "Some dish name", totalTime: 1800, imageURL: "", ration: .breakfast)
}

// MARK: - Nested types

extension Dish {
    
    enum DishRation: String, Codable {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"
    }
}

// MARK: - Hashable

extension Dish: Hashable {
    
}

// MARK: - Codable

extension Dish: Codable {
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name = "dishName"
        case totalTime = "dishTotalTime"
        case imageURL = "dishImageURL"
        case ration = "dishRation"
    }
}

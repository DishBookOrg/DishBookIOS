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
    
    
    init(dishName: String, time: Int) {
        self.name = dishName
        self.totalTime = time
        self.imageURL = ""
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
    }
}

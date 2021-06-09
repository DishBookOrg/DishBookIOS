//
//  Dish.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 05.02.2021.
//

import UIKit
import FirebaseFirestore

protocol Snapshotable {
    
    var id: String! { get set }
    var documentSnapshotMapper: (DocumentSnapshot) throws -> Self? { get }
}

extension Snapshotable where Self: Codable {
    
    var documentSnapshotMapper: (DocumentSnapshot) throws -> Self? {
        return {
            var model = try $0.data(as: Self.self)
            model?.id = $0.documentID
            return model
        }
    }
}

struct Dish: Codable, Snapshotable {
    
    
    var id: String!
    var name: String
    var totalTime: Int
    var imageURL: String
    
    
    init(dishName: String, time: Int) {
        self.name = dishName
        self.totalTime = time
        self.imageURL = ""
    }
        
    enum CodingKeys: String, CodingKey {
        
        case id
        case name = "dishName"
        case totalTime = "dishTotalTime"
        case imageURL = "dishImageURL"
    }
}

// MARK: - Hashable

extension Dish: Hashable {
    
}

// MARK: - Codable

extension Dish {
    
    
}

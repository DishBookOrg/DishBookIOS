//
//  Dish.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 05.02.2021.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

struct Dish {
    
    /// Document ID in `Firestore Database`
    @DocumentID var id: String?
    
    /// Property used when dish was added by another user
    /// It contains the id of the document in `Public dishes` collection
    /// If this property is not nil, `userAddedID` property
    /// must be not nil too.
    var dishID: String?
    
    /// Dish name
    var name: String
    
    /// Total time in seconds
    var totalTime: Int
    
    /// URL to image model.
    /// Use `.imageReference` with sd_setImage
    var imageURL: String?
    
    /// Number of servings choosen in NewDish
    var numberOfServings: Int
    
    /// Ration enum
    var ration: Ration
    
    /// Difficulty enum
    var difficulty: Difficulty
    
    /// Privacy enum
    var privacy: Privacy
    
    /// Date when dish was created
    var createdTime: Date
    
    /// User ID which create this dish
    var userCreatedID: String
    
    /// Used only when dish was added by another user.
    /// If this property is not nil, `dishID` property
    /// must be not nil too.
    var userAddedID: String?
    
    /// This  value is used to make possible display 2 dishes in different sections in one collection
    var blockId: Int?
    
    var ingredientsAndSteps: IngredientsAndSteps?
}

// MARK: - Computed properties

extension Dish {
    
    var stringTotalTimeShort: String {
        
        let minutes = totalTime / 60
        return "\(minutes) m"
    }
    
    var stringTotalTimeFull: String {
        
        let minutes = totalTime / 60
        let seconds = totalTime % 60
        
        return seconds == 0 ? "\(minutes) min" : "\(minutes) min \(seconds) s."
    }
    
    var imageReference: StorageReference {
        
        return (imageURL ?? "").imageReference
    }
}

// MARK: - Nested types

extension Dish {
    
    enum Ration: String, Codable {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"
    }
    
    enum Difficulty: Int, Codable {
        case easy = 1
        case medium = 2
        case hard = 3
    }
    
    enum Privacy: Int, Codable {
        case `public` = 0
        case `private` = 1
    }
}

// MARK: - Hashable

extension Dish: Hashable {
    
}

// MARK: - Codable

extension Dish: Codable {
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case dishID = "dishID"
        case name = "dishName"
        case totalTime = "dishTotalTime"
        case imageURL = "dishImageURL"
        case ration = "dishRation"
        case difficulty = "dishDifficulty"
        case createdTime = "dishCreatedTime"
        case userCreatedID = "userCreatedID"
        case userAddedID = "userAddedID"
        case privacy = "dishPrivacy"
        case numberOfServings = "dishNumberOfServings"
    }
}

// MARK: - Static properties

extension Dish {
    
    static var mock = Dish(id: UUID().uuidString,
                           name: "Some dish name",
                           totalTime: 1800,
                           imageURL: "",
                           numberOfServings: 4,
                           ration: .breakfast,
                           difficulty: .easy,
                           privacy: .public,
                           createdTime: Date(),
                           userCreatedID: "",
                           blockId: nil)
}

// MARK: - Dish + Array

extension Array where Element == Dish {
    
    func addBlockId(_ id: Int) -> [Element] {
        
        var arrayCopy = self
        for index in arrayCopy.indices {
            arrayCopy[index].blockId = id
        }
        return arrayCopy
    }
}


extension Dish.Difficulty: StringConvertible {
    
    var stringValue: String {
        switch self {
        case .easy:
            return R.string.newDish.segmentedControlDifficultyEasy()
        case .medium:
            return R.string.newDish.segmentedControlDifficultyMedium()
        case .hard:
            return R.string.newDish.segmentedControlDifficultyHard()
        }
    }
}

extension Dish.Privacy: StringConvertible {
    
    var stringValue: String {
        switch self {
        case .private:
            return R.string.newDish.segmentedControlPrivate()
        case .public:
            return R.string.newDish.segmentedControlPublic()
        }
    }
}


extension Dish {
    
    init(newDish: NewDish) {
        name = newDish.name ?? ""
        totalTime = newDish.totalTime ?? 0
        imageURL = newDish.imageURL ?? ""
        numberOfServings = newDish.numberOfServings ?? 0
        ration = .dinner
        difficulty = newDish.difficulty ?? .easy
        privacy = newDish.privacy ?? .private
        createdTime = Date()
        userCreatedID = App.user?.uid ?? ""
    }
}

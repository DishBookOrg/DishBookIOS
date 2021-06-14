//
//  NewFakingDish.swift
//  DishBookIOS
//
//  Created by Anastasia Holovash on 11.06.2021.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

struct NewDish {
    
    /// Document ID in `Firestore Database`
    @DocumentID var id: String?
    
    /// Property used when dish was added by another user
    /// It contains the id of the document in `Public dishes` collection
    /// If this property is not nil, `userAddedID` property
    /// must be not nil too.
    var dishID: String?
    
    /// Dish name
    var name: String?
    
    /// Total time in seconds
    var totalTime: Int?
    
    /// URL to image model.
    ///
    /// ``` swift
    /// // How to set image to imageView
    /// dishImageView.sd_setImage(with: Storage.storage().reference(forURL: imageURL),
    ///                           placeholderImage: UIImage())
    /// ```
    var imageURL: String?
    
    /// Ration enum
    var ration: Dish.Ration?
    
    /// Difficulty enum
    var difficulty: Dish.Difficulty?
    
    /// Privacy enum
    var privacy: Dish.Privacy?
    
    /// Used only when dish was added by another user.
    /// If this property is not nil, `dishID` property
    /// must be not nil too.
    var userCreatedD: String?

}

// MARK: - Hashable

extension NewDish: Hashable {
    
}

// MARK: - Codable

//extension NewFakingDish: Codable {
//
//    enum CodingKeys: String, CodingKey {
//
//        case id
//        case dishID = "dishID"
//        case name = "dishName"
//        case totalTime = "dishTotalTime"
//        case imageURL = "dishImageURL"
//        case ration = "dishRation"
//        case difficulty = "dishDifficulty"
//        case userCreatedID = "userCreatedID"
//        case privacy = "dishPrivacy"
//    }
//}

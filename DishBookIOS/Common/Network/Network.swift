//
//  Network.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 05.02.2021.
//

import CombineFirebase
import Firebase
import Combine

struct API {
    
    static let shared = API()
    
    let ref: DatabaseReference = Database.database().reference()
    
    enum Root: String {
        case dishBook = "DishBook"
        case publicDishes = "PublicDishes"
        case users = "Users"
    }
    
    func reference(for root: Root) -> DatabaseReference {
        return ref.child(root)
    }
}




extension DatabaseReference {
    
    func child(_ root: API.Root) -> DatabaseReference {
        return child(root.rawValue)
    }
}

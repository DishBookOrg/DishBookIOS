//
//  Network.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 24.05.2021.
//

import CombineFirebase
import Firebase
import Combine

struct APIClient {
    
    static let shared = APIClient()
    
    let db: Firestore = Firestore.firestore()
    
    
    enum Root: String {
        case dishBook = "DishBook"
        case publicDishes = "PublicDishes"
        case users = "Users"
    }
//
//    func reference(for root: Root) -> DatabaseReference {
//        return ref.child(root)
//    }
    
    func collection(for root: Root) -> CollectionReference {
        return db.collection(root)
    }
}




extension Firestore {
    
    func collection(_ root: APIClient.Root) -> CollectionReference {
        return collection(root.rawValue)
    }
}

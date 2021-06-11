//
//  APIClient.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 24.05.2021.
//

import Firebase
import Combine
import CombineFirebase

struct APIClient {
    
    // MARK: - Static properties
    
    static let shared = APIClient()
    
    // MARK: - Nested models
    
    enum RootCollection: String {
        case dishBook = "DishBook"
        case publicDishes = "PublicDishes"
        case users = "Users"
    }
    
    // MARK: - Static properties
    
    let db: Firestore = Firestore.firestore()
    
    // MARK: - Lifecycle
    
    private init() { }
    
    // MARK: - Public methods
    
    func collection(for root: RootCollection) -> CollectionReference {
        return db.collection(root)
    }
}

// MARK: - Firestore + APIClient

extension Firestore {
    
    func collection(_ root: APIClient.RootCollection) -> CollectionReference {
        return collection(root.rawValue)
    }
}

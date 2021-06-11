//
//  ExploreListViewModel.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 02.02.2021.
//

import Combine
import CombineFirebaseFirestore
import Firebase

final class ExploreListViewModel: BaseViewModel {
    
    // MARK: - Closures
    
    var onShowDetails: VoidClosure?
    
    // MARK: - Published properties
    
    @Published var tryItDishes: [Dish] = []
    
    @Published var breakfastDishes: [Dish] = []
    @Published var dinnerDishes: [Dish] = []
    @Published var lunchDishes: [Dish] = []
    
    // MARK: - Lifecycle
    
    override init() {
        super.init()
        
        getTryItDishes()
    }
    
    // MARK: - Public properties
    
    func getTryItDishes() {
        
        showLoader = true
        
        APIClient
            .shared
            .collection(for: .publicDishes)
            .limit(to: 10)
            .getDocuments(as: Dish.self)
            .sink { [weak self] completion in
                
                self?.showLoader = false
                if let error = try? completion.error() {
                    print("❗️ failure: \(error)")
                }
                
            } receiveValue: { [weak self] documents in
                self?.showLoader = false
                self?.tryItDishes = documents
            }
            .store(in: &cancelableSet)
    }
}

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
    @Published var lunchDishes: [Dish] = []
    @Published var dinnerDishes: [Dish] = []
    @Published var dishesInSearch: [Dish] = []
    
    // MARK: - Publishers with subjects
    
    lazy var didPressDishDetailPublisher = didPressDishDetailSubject.eraseToAnyPublisher()
    let didPressDishDetailSubject = PassthroughSubject<Dish, Never>()
    
    // MARK: - Lifecycle
    
    override init() {
        super.init()
        
        showLoader = true
        
        getTryItDishes()
        getRationDishes(.breakfast)
        getRationDishes(.lunch)
        getRationDishes(.dinner)
    }
    
    // MARK: - Public publisher variables
    
    var sections: AnyPublisher<[ExploreListCollectionBlock], Never> {
        
        return Publishers.CombineLatest($tryItDishes, Publishers.CombineLatest3($breakfastDishes, $lunchDishes, $dinnerDishes))
            .map { args -> ([Dish], [Dish], [Dish], [Dish]) in
                return (args.0, args.1.0, args.1.1, args.1.2)
            }
            .map { [weak self] tryItDishes, breakfastDishes, lunchDishes, dinnerDishes -> [ExploreListCollectionBlock] in
                
                var sections: [ExploreListCollectionBlock] = []
                
                if !tryItDishes.isEmpty {
                    sections.append(ExploreListCollectionBlock(section: .bigSection(id: 0, title: "Try it!"),
                                                               items: tryItDishes))
                }
                
                if !breakfastDishes.isEmpty {
                    sections.append(ExploreListCollectionBlock(section: .smallSection(id: 0, ration: .breakfast),
                                                               items: breakfastDishes))
                }
                
                if !lunchDishes.isEmpty {
                    sections.append(ExploreListCollectionBlock(section: .smallSection(id: 1, ration: .lunch),
                                                               items: lunchDishes))
                }
                
                if !dinnerDishes.isEmpty {
                    sections.append(ExploreListCollectionBlock(section: .smallSection(id: 2, ration: .dinner),
                                                               items: dinnerDishes))
                }
                
                self?.showLoader = sections.isEmpty
                
                return sections
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Public methods
    
    func getTryItDishes() {
        
        APIClient
            .shared
            .collection(for: .publicDishes)
            .order(by: "dishCreatedTime", descending: true)
            .limit(to: 25)
            .publisher(as: Dish.self)
            .sink { [weak self] completion in
                
                self?.showLoader = false
                
                if let error = try? completion.error() {
                    print("❗️ failure: \(error)")
                }
                
            } receiveValue: { [weak self] dishes in
                
                
                self?.tryItDishes = dishes.addBlockId(0)
            }
            .store(in: &cancelableSet)
    }
    
    func getRationDishes(_ ration: Dish.Ration) {
        
        APIClient
            .shared
            .collection(for: .publicDishes)
            .whereField("dishRation", in: [ration.rawValue])
            .order(by: "dishCreatedTime", descending: true)
            .limit(to: 25)
            .publisher(as: Dish.self)
            .sink { [weak self] completion in
                
                self?.showLoader = false
                if let error = try? completion.error() {
                    print("❗️ failure: \(error)")
                }
                
            } receiveValue: { [weak self] dishes in
                
                switch ration {
                case .breakfast:
                    self?.breakfastDishes = dishes.addBlockId(1)
                case .lunch:
                    self?.lunchDishes = dishes.addBlockId(2)
                case .dinner:
                    self?.dinnerDishes = dishes.addBlockId(3)
                }
            }
            .store(in: &cancelableSet)
    }
    
    func searchDishes(with name: String) {
        
        showLoader = true
        
        APIClient
            .shared
            .collection(for: .publicDishes)
            .order(by: "dishName")
            .whereField("dishName", isGreaterThanOrEqualTo: name)
            .whereField("dishName", isLessThanOrEqualTo: name + "z")
            .limit(to: 100)
            .getDocuments(as: Dish.self)
            .sink { [weak self] completion in
                
                self?.showLoader = false
                if let error = try? completion.error() {
                    print("❗️ failure: \(error)")
                }
                
            } receiveValue: { [weak self] dishes in
                print(dishes)
                self?.dishesInSearch = dishes
            }
            .store(in: &cancelableSet)
    }
}

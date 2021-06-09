//
//  ExploreListViewModel.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 02.02.2021.
//

import Firebase
import Combine
import CombineFirebaseFirestore

final class ExploreListViewModel: BaseViewModel {
    
    var onShowDetails: VoidClosure?
    
    var dishes: [Dish] = []
    
    
    override init() {
        super.init()
        
        var dishDocumentSnapshotMapper: (DocumentSnapshot) throws -> Dish? {
            return {
                var dish = try $0.data(as: Dish.self)
                dish?.id = $0.documentID
                return dish
            }
        }
        
//        var defaultMapper: (QuerySnapshot, (DocumentSnapshot) throws -> Dish?) -> [Dish] {
//            return { snapshot, documentSnapshotMapper in
//                var dArray: [Dish] = []
//                snapshot.documents.forEach {
//                    do {
//                        if let d = try documentSnapshotMapper($0) {
//                            dArray.append(d)
//                        }
//                    } catch {
//                        print("Document snapshot mapper error for \($0.reference.path): \(error)")
//                    }
//                }
//                return dArray
//            }
//        }
        
        APIClient
            .shared
            .collection(for: .dishBook)
            .limit(to: 1)
            .getDocuments(as: Dish.self, documentSnapshotMapper: dishDocumentSnapshotMapper)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("🏁 finished")
                case .failure(let error):
                    print("❗️ failure: \(error)")
                }
            }) { documents in
                print(documents)
            }
            .store(in: &cancelableSet)
    }
}


extension Query {

    func getDocuments<D: Decodable>(source: FirestoreSource = .default, as type: D.Type, documentSnapshotMapper: @escaping (DocumentSnapshot) throws -> D? = DocumentSnapshot.defaultMapper(), querySnapshotMapper: @escaping (QuerySnapshot, (DocumentSnapshot) throws -> D?) -> [D] = QuerySnapshot.defaultMapper()) -> AnyPublisher<[D], Error> {
        getDocuments(source: source)
            .map { querySnapshotMapper($0, documentSnapshotMapper) }
            .eraseToAnyPublisher()
    }
    
//    func getDocuments<D: Decodable & Snapshotable>(as type: D.Type) {
//
//        getDocuments(source: FirestoreSource.default)
//            .map { QuerySnapshot.defaultMapper($0, documentSnapshotMapper) }
//            .eraseToAnyPublisher()
//    }
}

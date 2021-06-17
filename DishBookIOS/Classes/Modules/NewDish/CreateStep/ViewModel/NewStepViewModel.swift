//
//  NewStepViewModel.swift
//  DishBookIOS
//
//  Created by Anastasia Holovash on 16.06.2021.
//

import UIKit
import Combine
import FirebaseStorage
import CombineFirebaseStorage

final class NewStepViewModel: BaseViewModel {
    
    // MARK: - Publishers
    
    lazy var didPressDonePublisher = didPressDoneSubject.eraseToAnyPublisher()
    lazy var didPressBackPublisher = didPressBackSubject.eraseToAnyPublisher()
    
    // MARK: - Subjects
    
    let didPressDoneSubject = PassthroughSubject<IngredientsAndSteps.Step, Never>()
    let didPressBackSubject = PassthroughSubject<Void, Never>()
    
    let stepNumber: Int
    var step: IngredientsAndSteps.Step
    
    init(stepNumber: Int, step: IngredientsAndSteps.Step) {
        
        self.stepNumber = stepNumber
        self.step = step
    }
}

// MARK: - API

extension NewStepViewModel {
    
    func loadImage(_ image: UIImage) {
        
        showLoader = true
        
        guard let data = image.jpegData(compressionQuality: 0.7) else {
            return
        }
        
        let newURL = "https://firebasestorage.googleapis.com/v0/b/dishbookapp.appspot.com/o/\(UUID().uuidString).jpeg"
        let reference = Storage
            .storage()
            .reference(forURL: newURL)
                
        (reference.putData(data) as AnyPublisher<StorageMetadata, Error>)
            .sink { [weak self] completion in
                
                self?.showLoader = false
                
                switch completion {
                case .finished:
                    self?.step.stepAttachmentURL = newURL
                    print("🏁 finished")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] metadata in
                self?.showLoader = false
                print(metadata)
            }
            .store(in: &cancelableSet)
    }
}

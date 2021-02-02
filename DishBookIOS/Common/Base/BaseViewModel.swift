//
//  BaseViewModel.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 30.01.2021.
//

import UIKit
import Combine

class BaseViewModel: ObservableObject, ClosableCoordinator {
    
    // MARK: - Published Properties
    
    @Published var showLoader = false
    
    // MARK: - Public Properties
    
    var cancelableSet: Set<AnyCancellable> = []
    
    var onClose: VoidClosure?
}

protocol ClosableCoordinator {
    
    var onClose: VoidClosure? { get set }
}

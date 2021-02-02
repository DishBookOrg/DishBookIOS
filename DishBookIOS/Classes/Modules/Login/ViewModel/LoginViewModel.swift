//
//  LoginViewModel.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 30.01.2021.
//

import Foundation

final class LoginViewModel: BaseViewModel {
    
    // MARK: - Closure properties
    
    var appleAuthAction: VoidClosure?
    var googleAuthAction: VoidClosure?
    
    var didLogin: VoidClosure?
    
    
    var currentNonce: String?
}

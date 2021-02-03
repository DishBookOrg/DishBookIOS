//
//  SubscribersCompletion+Ext.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 03.02.2021.
//

import Combine

extension Subscribers.Completion {
    
    func error() throws -> Failure {
        
        if case let .failure(error) = self {
            return error
        }
        throw ErrorFunctionThrowsError.error
    }
    
    private enum ErrorFunctionThrowsError: Error {
        case error
    }
}

//
//  String+StorageRef.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 17.06.2021.
//

import Foundation
import FirebaseStorage

extension String {
    
    var imageReference: StorageReference {
        return Storage.storage().reference(forURL: self)
    }
}

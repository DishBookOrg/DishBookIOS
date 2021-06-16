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
        
        if contains("gs://") || contains("http://") || contains("https://") {
            return Storage.storage().reference(forURL: self)
        } else {
            return Storage.storage().reference(forURL: "https://firebasestorage.googleapis.com/v0/b/dishbookapp.appspot.com/o/chicken.jpg")
        }
    }
}

//
//  Dish.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 05.02.2021.
//

import UIKit

struct Dish: Hashable {
    
    var dishName: String
    var time: Int
    var image: UIImage = R.image.dishMockImage()!
}

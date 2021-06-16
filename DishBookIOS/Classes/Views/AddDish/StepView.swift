//
//  StepView.swift
//  DishBookIOS
//
//  Created by Anastasia Holovash on 16.06.2021.
//

import UIKit

final class StepView: UIView {
    
    private let backgroundImageView = UIImageView()
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    private func setup() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import SwiftUI
struct StepViewPreview: PreviewProvider {
    
    static var previews: some View {
        ViewRepresentable(StepView()) { view in
            
        }
        .previewLayout(.fixed(width: 337, height: 132))
    }
}

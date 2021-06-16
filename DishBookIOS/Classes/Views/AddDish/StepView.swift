//
//  StepView.swift
//  DishBookIOS
//
//  Created by Anastasia Holovash on 16.06.2021.
//

import UIKit

final class StepView: UIView {
    
    struct Props {
        let image: UIImage?
        let stepNumber: Int
        let description: String
    }
    
    private let backgroundImageView = UIImageView()
    private let imageView = UIImageView()
    private let descriptionLabel = UILabel()
    private let titleLabel = UILabel()
    
    private var renderedProps: Props?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    func render(props: Props) {
        if props.image != renderedProps?.image {
            backgroundImageView.image = props.image
            imageView.image = props.image
        }
        if props.stepNumber != renderedProps?.stepNumber {
            
        }
        if props.description != renderedProps?.description {
            
        }
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

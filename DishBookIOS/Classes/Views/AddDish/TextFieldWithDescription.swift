//
//  TextFieldWithDescription.swift
//  DishBookIOS
//
//  Created by Anastasia Holovash on 08.06.2021.
//

import UIKit
import Combine

final class TextFieldWithDescription: UIView {
    
    lazy var didChangeTextPublisher = nameTextField.textPublisher
    
    private let nameTextField = UITextField()
    private let descriptionLabel = DescriptionUILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    private func setup() {
        
        nameTextField.font = R.font.sfProRoundedSemibold(size: 30)
        nameTextField.textColor = R.color.textBlack()
        
        let spacer = UIView()
        spacer.backgroundColor = R.color.textDescriptionGray()
        
        addSubview(nameTextField, constraints: [
            nameTextField.topAnchor.constraint(equalTo: topAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        addSubview(spacer, constraints: [
            spacer.topAnchor.constraint(equalTo: topAnchor, constant: 35),
            spacer.leadingAnchor.constraint(equalTo: leadingAnchor),
            spacer.trailingAnchor.constraint(equalTo: trailingAnchor),
            spacer.heightAnchor.constraint(equalToConstant: 2)
        ])
        
        addSubview(descriptionLabel, constraints: [
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    public func setup(placeholder: String, description: String) {
        
        nameTextField.placeholder = placeholder
        descriptionLabel.text = description
    }
}

import SwiftUI
struct TextFieldWithDescriptionPreview: PreviewProvider {
    
    static var previews: some View {
        ViewRepresentable(TextFieldWithDescription()) { view in
            view.setup(placeholder: "Name", description: "Write the name of the dish.")
        }
        .previewLayout(.fixed(width: 343, height: 60))
    }
}

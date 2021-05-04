//
//  TextFieldWithDescription.swift
//  DishBookIOS
//
//  Created by Anastasia Holovash on 09.03.2021.
//

import UIKit

final class TextFieldWithDescription: UIView {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionLabel: DescriptionUILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    private func setup() {
        fromNib()
        
        nameTextField.font = R.font.sfProRoundedSemibold(size: 30)
        nameTextField.textColor = R.color.textBlack()
    }
    
    public func setup(placeholder: String, description: String) {
        
        nameTextField.placeholder = placeholder
        descriptionLabel.text = description
    }
}
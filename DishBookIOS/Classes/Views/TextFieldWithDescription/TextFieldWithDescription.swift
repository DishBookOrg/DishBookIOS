//
//  TextFieldWithDescription.swift
//  DishBookIOS
//
//  Created by Anastasia Holovash on 09.03.2021.
//

import UIKit

final class TextFieldWithDescription: UIView {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    private func loudViewFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "TextFieldWithDescription", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView ?? UIView()
    }
    
    private func setup() {
        
        let xibView = loudViewFromXib()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(xibView)
        
        nameTextField.font = R.font.sfProRoundedSemibold(size: 30)
        nameTextField.textColor = R.color.textBlack()
        descriptionLabel.font = R.font.sfProRoundedMedium(size: 12)
        descriptionLabel.textColor = R.color.textDescriptionGray()
    }
    
    public func setup(placeholder: String, description: String) {
        
        nameTextField.placeholder = placeholder
        descriptionLabel.text = description
    }
}

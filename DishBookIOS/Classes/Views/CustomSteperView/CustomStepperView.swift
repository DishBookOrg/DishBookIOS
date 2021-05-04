//
//  CustomSteperView.swift
//  DishBookIOS
//
//  Created by Anastasia Holovash on 10.03.2021.
//

import UIKit

protocol StepperViewDelegate: AnyObject {
    
    func newValueSeted(value: Int)
}

final class CustomStepperView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: DescriptionUILabel!
    @IBOutlet weak var steperDisplayLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    private var currentStep: Int = 0
    
    weak var delegate: StepperViewDelegate?
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        fromNib()
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        fromNib()
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        apply(style: Styles.View.shadow16)
    }
    
    private func setup() {
        
        titleLabel.font = R.font.sfProRoundedMedium(size: 20)
        titleLabel.textColor = R.color.textWhite()
        steperDisplayLabel.font = R.font.sfProRoundedMedium(size: 20)
        steperDisplayLabel.textColor = R.color.textWhite()
        minusButton.titleLabel?.font = R.font.sfProRoundedMedium(size: 30)
        plusButton.titleLabel?.font = R.font.sfProRoundedMedium(size: 30)
        
        apply(style: Styles.View.shadow16)
    }
    
    public func config(initialValue: Int, isAllCornersRounded: Bool = true) {
        
        currentStep = initialValue
        
        if !isAllCornersRounded {
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }
    
    @IBAction func didPressMinusButton(_ sender: UIButton) {
        
        currentStep = currentStep > 0 ? currentStep - 1 : 0
        steperDisplayLabel.text = String(currentStep)
        delegate?.newValueSeted(value: currentStep)
    }
    
    @IBAction func didPressPlusButton(_ sender: UIButton) {
        
        currentStep = currentStep < Int.max ? currentStep + 1 : Int.max
        steperDisplayLabel.text = String(currentStep)
        delegate?.newValueSeted(value: currentStep)
    }
    
}

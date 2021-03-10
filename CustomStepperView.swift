//
//  CustomSteperView.swift
//  DishBookIOS
//
//  Created by Anastasia Holovash on 10.03.2021.
//

import UIKit

protocol StepperViewDelegate: class {
    
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
    
    private func setup() {
        
        titleLabel.font = R.font.sfProRoundedMedium(size: 20)
        titleLabel.textColor = R.color.textWhite()
        steperDisplayLabel.font = R.font.sfProRoundedMedium(size: 20)
        steperDisplayLabel.textColor = R.color.textWhite()
    }
    
    override func layoutSubviews() {
        
        let shadows = UIView()
        shadows.frame = minusButton.frame
        shadows.clipsToBounds = false
        minusButton.addSubview(shadows)
        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 0)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 4
        layer0.shadowOffset = CGSize(width: 0, height: 4)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)
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

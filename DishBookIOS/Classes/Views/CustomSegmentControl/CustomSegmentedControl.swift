//
//  CustomSegmentedControl.swift
//  DishBookIOS
//
//  Created by Anastasia Holovash on 09.03.2021.
//

import UIKit

class CustomSegmentedControl: UIControl {

    @IBOutlet weak var descriptionLabel: DescriptionUILabel!
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var gradientImage: UIImageView!
    @IBOutlet weak var selectedLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var selectedViewLeading: NSLayoutConstraint!
    @IBOutlet weak var selectedViewWidth: NSLayoutConstraint!

    private var segments: [String] = []
    private var buttons: [UIButton] = []
    
    private var segmentWidth: CGFloat = 0
    
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
        let nib = UINib(nibName: "CustomSegmentedControl", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView ?? UIView()
    }
    
    private func setup() {
        
        let xibView = loudViewFromXib()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(xibView)
        
        selectedLabel.font = R.font.sfProRoundedSemibold(size: 15)
        selectedLabel.textColor = R.color.textWhite()
    }
    
    override func layoutSubviews() {
        
        selectedView.layer.cornerRadius = 10
        gradientImage.layer.cornerRadius = 10
        gradientImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        if !segments.isEmpty {
            segmentWidth = stackView.frame.width / CGFloat(segments.count)
            selectedViewWidth.constant = segmentWidth
        }
    }
    
    public func config(segmentsNames: [String], descriptionText: String) {
        
        segments = segmentsNames
        
        segments.forEach { name in
            let button = UIButton()
            button.titleLabel?.font = R.font.sfProRoundedSemibold(size: 15)
            button.setTitleColor(R.color.textBlack(), for: .normal)
            button.setTitle(name, for: .normal)
            button.titleLabel?.textAlignment = .center
            button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        selectedLabel.text = segments[0]
        descriptionLabel.text = descriptionText
    }
    
    @objc
    private func buttonAction(sender: UIButton) {

        let index = buttons.firstIndex(of: sender) ?? 0
        
        self.gradientImage.layer.cornerRadius = 0
        self.gradientImage.layer.maskedCorners = []

        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: UIView.AnimationOptions.curveEaseIn) {
            
            self.selectedView.frame.origin.x = self.segmentWidth * CGFloat(index)
            self.gradientImage.layer.cornerRadius = 10

            if index == 0 {
                self.gradientImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            } else if index == self.buttons.count - 1 {
                self.gradientImage.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            } else {
                self.gradientImage.layer.maskedCorners = []
            }
            
            self.selectedLabel.text = self.segments[index]
        }
    }
}

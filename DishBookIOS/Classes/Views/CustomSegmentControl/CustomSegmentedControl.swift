//
//  CustomSegmentedControl.swift
//  DishBookIOS
//
//  Created by Anastasia Holovash on 09.03.2021.
//

import UIKit

class CustomSegmentedControl: UIControl {

    // MARK: - @IBOutlets
    
    @IBOutlet weak var descriptionLabel: DescriptionUILabel!
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var gradientImage: UIImageView!
    @IBOutlet weak var selectedLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    // NSLayoutConstraints
    @IBOutlet weak var selectedViewLeading: NSLayoutConstraint!
    @IBOutlet weak var selectedViewWidth: NSLayoutConstraint!

    // MARK: - Private variables
    
    private var segments: [String] = []
    private var segmentWidth: CGFloat = 0
    
    // MARK: - Lifecycle
    
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
        
        selectedLabel.font = R.font.sfProRoundedSemibold(size: 15)
        selectedLabel.textColor = R.color.textWhite()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(sliderTapped(_:)))
        stackView.addGestureRecognizer(tap)
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
            let label = UILabel()
            label.font = R.font.sfProRoundedSemibold(size: 15)
            label.textColor = R.color.textBlack()
            label.text = name
            label.textAlignment = .center
            label.backgroundColor = .systemBackground
            stackView.addArrangedSubview(label)
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        selectedLabel.text = segments[0]
        descriptionLabel.text = descriptionText
    }
    
    // MARK: - @objc
    
    @objc
    func sliderTapped(_ gestureRecognizer: UIGestureRecognizer) {
        
        let pointTapped: CGPoint = gestureRecognizer.location(in: self)
        let index = Int(pointTapped.x / segmentWidth)
                
        self.gradientImage.layer.cornerRadius = 0
        self.gradientImage.layer.maskedCorners = []

        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: UIView.AnimationOptions.curveEaseIn) {

            self.selectedView.frame.origin.x = self.segmentWidth * CGFloat(index)
            self.gradientImage.layer.cornerRadius = 10

            if index == 0 {
                self.gradientImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            } else if index == self.segments.count - 1 {
                self.gradientImage.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            } else {
                self.gradientImage.layer.maskedCorners = []
            }
            self.selectedLabel.text = self.segments[index]
        }
    }
}

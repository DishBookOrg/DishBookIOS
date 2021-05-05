//
//  SegmentedControl.swift
//  DishBookIOS
//
//  Created by Anastasia Holovash on 04.05.2021.
//

import UIKit

// TODO: Change to publisher
protocol SegmentedControlDelegate: AnyObject {
    
    /// Calls when selected segment changed
    /// - Parameter index: index of selected segment
    func selectedSegmentChanged(index: Int)
}

class SegmentedControl: UIControl {

    struct Props {
        
        let segmentsNames: [String]
        let descriptionText: String
    }
    
    private let descriptionLabel = DescriptionUILabel()
    private let selectedView = UIView()
    private let selectedLabel = UILabel()
    private let stackView = UIStackView()
    
    // NSLayoutConstraints
    
    private lazy var selectedViewLeading = selectedView.leadingAnchor.constraint(equalTo: leadingAnchor)
    private lazy var selectedViewWidth = selectedView.widthAnchor.constraint(equalToConstant: segmentWidth)
    
    // MARK: - Delegate
    
    weak var delegate: SegmentedControlDelegate?

    // MARK: - Private variables
    
    private var segments: [String] = []
    private var segmentWidth: CGFloat = 0
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func render(props: Props) {
        
        segments = props.segmentsNames
        
        if !segments.isEmpty {
            segmentWidth = stackView.frame.width / CGFloat(segments.count)
            selectedViewWidth.constant = segmentWidth
        }
        
        segments.forEach { name in
            let label = UILabel()
            label.font = R.font.sfProRoundedSemibold(size: 15)
            label.textColor = R.color.textBlack()
            label.text = name
            label.textAlignment = .center
            label.backgroundColor = .systemBackground
            label.isUserInteractionEnabled = true
            stackView.addArrangedSubview(label)
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        selectedLabel.text = segments[0]
        descriptionLabel.text = props.descriptionText
        delegate?.selectedSegmentChanged(index: 0)
    }
    
    private func setup() {
        
        addSubview(descriptionLabel, constraints: [
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 16)
        ])

        setupStackView()
        setupSelectedView()
    }
    
    private func setupStackView() {
        
        stackView.distribution = .fillEqually
        stackView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(sliderTapped(_:)))
        stackView.addGestureRecognizer(tap)
        
        stackView.backgroundColor = R.color.primaryOrangeMuted()
        stackView.spacing = 1
        stackView.borderWidth = 1
        stackView.borderColor = R.color.primaryOrangeMuted()
        stackView.layer.cornerRadius = 10
        
        addSubview(stackView, constraints: [
            stackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 6),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func setupSelectedView() {
        
        selectedLabel.font = R.font.sfProRoundedSemibold(size: 15)
        selectedLabel.textColor = R.color.textWhite()
        selectedLabel.textAlignment = .center
        
        selectedView.isUserInteractionEnabled = true
        selectedView.apply(style: Styles.View.mutedGradient)
        selectedView.addSubview(selectedLabel, withEdgeInsets: .zero)
        selectedView.apply(style: Styles.View.cornerRadius10)
        selectedView.apply(style: Styles.View.maskedRightCorners)

        addSubview(selectedView, constraints: [
            selectedViewLeading,
            selectedViewWidth,
            selectedView.heightAnchor.constraint(equalToConstant: 35),
            selectedView.topAnchor.constraint(equalTo: stackView.topAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        selectedView.apply(style: Styles.View.mutedGradient)
        
        if !segments.isEmpty {
            segmentWidth = stackView.frame.width / CGFloat(segments.count)
            selectedViewWidth.constant = segmentWidth
        }
    }
    
    // MARK: - @objc
    
    @objc
    func sliderTapped(_ gestureRecognizer: UIGestureRecognizer) {
        
        let pointTapped: CGPoint = gestureRecognizer.location(in: self)
        let index = Int(pointTapped.x / segmentWidth)
                
        self.selectedView.apply(style: Styles.View.cornerRadius0)
        self.selectedView.apply(style: Styles.View.noMaskedCorners)
        selectedLabel.font = R.font.sfProRoundedSemibold(size: 16)

        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: UIView.AnimationOptions.curveEaseIn) {

            self.selectedView.frame.origin.x = self.segmentWidth * CGFloat(index)
            self.selectedView.apply(style: Styles.View.cornerRadius10)

            if index == 0 {
                self.selectedView.apply(style: Styles.View.maskedRightCorners)
            } else if index == self.segments.count - 1 {
                self.selectedView.apply(style: Styles.View.maskedLeftCorners)
            } else {
                self.selectedView.apply(style: Styles.View.noMaskedCorners)
            }
            
            self.selectedLabel.text = self.segments[index]
        } completion: { _ in
            self.selectedLabel.font = R.font.sfProRoundedSemibold(size: 15)
            self.delegate?.selectedSegmentChanged(index: index)
        }
    }
    

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        
        return true
    }
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.continueTracking(touch, with: event)
        
        return true
    }
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)

    }
}

import SwiftUI
struct SegmentedControlPreview: PreviewProvider {
    
    
    static var previews: some View {
        ViewRepresentable(SegmentedControl()) { view in
            view.render(props: SegmentedControl.Props(segmentsNames: ["Easy", "Medium"], descriptionText: "Some test text?"))
        }
        .previewLayout(.fixed(width: 414, height: 57))
    }
}

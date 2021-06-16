//
//  SegmentedControl.swift
//  DishBookIOS
//
//  Created by Anastasia Holovash on 04.05.2021.
//

import UIKit
import Combine

class SegmentedControl: UIControl {
    
    // MARK: - Publisher
    
    lazy var didSelectPublisher = didSelectSubject.eraseToAnyPublisher()
    private let didSelectSubject = PassthroughSubject<StringConvertible, Never>()
    
    struct Props {
        
        let segmentsNames: [StringConvertible]
        let descriptionText: String
    }
    
    // MARK: - Private variables
    
    private let descriptionLabel = DescriptionUILabel()
    private let selectedView = UIView()
    private let selectedLabel = UILabel()
    private let stackView = UIStackView()
        
    private lazy var selectedViewLeading = selectedView.leadingAnchor.constraint(equalTo: leadingAnchor)
    private lazy var selectedViewWidth = selectedView.widthAnchor.constraint(equalToConstant: segmentWidth)
    
    private var segments: [StringConvertible] = []
    private var segmentWidth: CGFloat = 0
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        selectedView.apply(style: Styles.View.Gradient.muted)
        selectedView.apply(style: Styles.View.CornerRadius.d10)
        selectedView.apply(style: Styles.View.CornerRadius.maskedRight)
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
            label.text = name.stringValue
            label.textAlignment = .center
            label.backgroundColor = .systemBackground
            label.isUserInteractionEnabled = true
            stackView.addArrangedSubview(label)
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        selectedLabel.text = segments[0].stringValue
        descriptionLabel.text = props.descriptionText
        didSelectSubject.send(segments[0])
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
        selectedView.addSubview(selectedLabel, withEdgeInsets: .zero)
        
        addSubview(selectedView, constraints: [
            selectedViewLeading,
            selectedViewWidth,
            selectedView.heightAnchor.constraint(equalToConstant: 35),
            selectedView.topAnchor.constraint(equalTo: stackView.topAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        selectedView.apply(style: Styles.View.Gradient.muted)
        
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
        
        selectedView.apply(style: Styles.View.CornerRadius.d0)
        selectedView.apply(style: Styles.View.CornerRadius.noMasked)
        selectedLabel.font = R.font.sfProRoundedSemibold(size: 16)
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: UIView.AnimationOptions.curveEaseIn) { [self] in
            
            selectedView.frame.origin.x = segmentWidth * CGFloat(index)
            selectedView.apply(style: Styles.View.CornerRadius.d10)
            
            if index == 0 {
                selectedView.apply(style: Styles.View.CornerRadius.maskedRight)
            } else if index == self.segments.count - 1 {
                selectedView.apply(style: Styles.View.CornerRadius.maskedLeft)
            } else {
                selectedView.apply(style: Styles.View.CornerRadius.noMasked)
            }
            
            selectedLabel.text = segments[index].stringValue
        } completion: { [unowned self] _ in
            selectedLabel.font = R.font.sfProRoundedSemibold(size: 15)
            didSelectSubject.send(segments[index])
        }
    }
}

//
//  IngredientsView.swift
//  DishBookIOS
//
//  Created by Anastasia Holovash on 14.06.2021.
//

import UIKit
import Combine

final class IngredientsView: UIView {
    
    struct Props {
        
        let ingredients: [SingleIngredientView.Props]
        let isAllCornersRounded: Bool = true
    }
    
    private var gradientLayer: CAGradientLayer?
            
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        apply(style: Styles.View.Shadow.d16)
        gradientLayer?.frame = bounds
    }
    
    public func render(props: Props) {
        
        
        if !props.isAllCornersRounded {
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }
    
    private func setup() {
        
        minusButton
            .publisher(for: .touchUpInside)
            .sink { _ in self.currentStep = self.currentStep > 0 ? self.currentStep - 1 : 0 }
            .store(in: &cancellables)
        
        plusButton
            .publisher(for: .touchUpInside)
            .sink { _ in self.currentStep = self.currentStep < Int.max ? self.currentStep + 1 : Int.max }
            .store(in: &cancellables)
    }
    
    private func setupUI() {
        
        gradientLayer = apply(style: Styles.View.Gradient.muted)
        
        descriptionLabel.text = R.string.newDish.steperDescription()
        descriptionLabel.textColor = R.color.textDescriptionWhite()
        
        titleLabel.text = R.string.newDish.steperTitle()
        titleLabel.font = R.font.sfProRoundedMedium(size: 20)
        titleLabel.textColor = R.color.textWhite()
        
        stepperDisplayLabel.textAlignment = .center
        stepperDisplayLabel.font = R.font.sfProRoundedMedium(size: 20)
        stepperDisplayLabel.textColor = R.color.textWhite()
        
        setupCircleButton(with: "-", button: minusButton)
        setupCircleButton(with: "+", button: plusButton)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, minusButton, stepperDisplayLabel, plusButton])
        stackView.spacing = 6
        
        addSubview(descriptionLabel, constraints: [
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        addSubview(stackView, constraints: [
            stackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 6),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            stackView.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        NSLayoutConstraint.activate([
            minusButton.widthAnchor.constraint(equalToConstant: 35),
            stepperDisplayLabel.widthAnchor.constraint(equalToConstant: 35),
            plusButton.widthAnchor.constraint(equalToConstant: 35)
        ])
        
        apply(style: Styles.View.CornerRadius.small)
    }
    
    private func setupCircleButton(with title: String, button: UIButton) {
        
        button.apply(style: Styles.View.CornerRadius.d17)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 1, bottom: 4, right: 0)
        button.backgroundColor = .white
        button.setTitle(title, for: .normal)
        button.setTitleColor(R.color.textBlack(), for: .normal)
        button.titleLabel?.font = R.font.sfProRoundedMedium(size: 30)
    }
}

import SwiftUI
struct IngredientsViewPreview: PreviewProvider {
    
    static var previews: some View {
        ViewRepresentable(IngredientsView()) { view in
            view.render(props: IngredientsView.Props(ingredients: <#T##[SingleIngredientView.Props]#>))
        }
        .previewLayout(.fixed(width: 343, height: 85))
    }
}


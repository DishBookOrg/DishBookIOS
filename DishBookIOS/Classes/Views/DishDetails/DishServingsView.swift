//
//  DishServingsView.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 16.06.2021.
//

import UIKit
import Combine

final class DishServingsView: UIView {
    
    // MARK: - Props
        
    struct Props {
        var numberOfServings: Int
        var ingredients: [SingleIngredientView.Props]
    }
    
    // MARK: - Private properties
    
    private let stackView = UIStackView()
    private let stepperView = StepperView()
    private let separatorView = UIView()
    let ingredientsView = IngredientsView()
    
    // MARK: - Published properties
    
    @Published var numberOfServings: Int = 1
    
    // MARK: - Lifecycle
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        apply(style: Styles.View.Gradient.muted)
        apply(style: Styles.View.CornerRadius.small)
        apply(style: Styles.View.Shadow.d20)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        stackView.axis = .vertical
        addSubview(stackView, withEdgeInsets: .zero)
        
        separatorView.backgroundColor = R.color.textWhite()
        
        stepperView
            .$currentStep
            .assign(to: &$numberOfServings)
//            .store
        
        NSLayoutConstraint.activate([
            stepperView.heightAnchor.constraint(equalToConstant: 85),
            separatorView.heightAnchor.constraint(equalToConstant: 2),
            ingredientsView.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        ])
        
        stackView.addArrangedSubview(stepperView)
        stackView.addArrangedSubview(separatorView)
        stackView.addArrangedSubview(ingredientsView)
    }
    
    public func render(props: Props) {
        
        stepperView.render(props: StepperView.Props(initialValue: props.numberOfServings, isAllCornersRounded: false))
        ingredientsView.render(props: IngredientsView.Props(ingredients: props.ingredients, isAllCornersRounded: false))
    }
}

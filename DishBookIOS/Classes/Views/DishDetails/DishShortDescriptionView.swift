//
//  DishShortDescriptionView.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 14.06.2021.
//

import UIKit

final class DishShortDescriptionView: UIView {
    
    // MARK: - Props
    
    struct Props {
        
        let dishName: String
        let difficulty: Dish.Difficulty
        let totalTimeFull: String
    }
    
    // MARK: - Private properties
    
    private let dishNameLabel = UILabel()
    private let dishTotalTimeLabel = UILabel()
    private let dishDifficultyLabel = UILabel()
    private let dishDifficultyView = DishDifficultyView()
    
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
        
        dishNameLabel.apply(style: Styles.Font.Rounded.SB.f2)
        dishNameLabel.textColor = R.color.textWhite()
        dishNameLabel.textAlignment = .center
        dishNameLabel.numberOfLines = 0
        
        addSubview(dishNameLabel, constraints: [
            dishNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            dishNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dishNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        let bottomStackView = UIStackView()
        bottomStackView.axis = .horizontal
        bottomStackView.alignment = .bottom
        bottomStackView.spacing = 6
        
        dishTotalTimeLabel.apply(style: Styles.Font.Rounded.SB.f5)
        dishTotalTimeLabel.textColor = R.color.textWhite()
        
        dishDifficultyLabel.apply(style: Styles.Font.Rounded.SB.f5)
        dishDifficultyLabel.textColor = R.color.textWhite()
        
        bottomStackView.addArrangedSubview(dishTotalTimeLabel)
        bottomStackView.addArrangedSubview(UIView())
        bottomStackView.addArrangedSubview(dishDifficultyLabel)
        bottomStackView.addArrangedSubview(dishDifficultyView)
        
        addSubview(bottomStackView, constraints: [
            bottomStackView.topAnchor.constraint(equalTo: dishNameLabel.bottomAnchor, constant: 11),
            bottomStackView.heightAnchor.constraint(equalToConstant: 24),
            
            bottomStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            bottomStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            bottomStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
    
    public func render(props: Props) {
        
        dishTotalTimeLabel.text = "􀐫 \(props.totalTimeFull)"
        dishNameLabel.text = props.dishName
        dishDifficultyLabel.text = props.difficulty.stringValue
        dishDifficultyView.render(props: props.difficulty)
    }
}

// MARK: - Preview

import SwiftUI
struct DishShortDescriptionViewPreview: PreviewProvider {
    
    static var previews: some View {
        ViewRepresentable(DishShortDescriptionView()) { view in
            view.render(props: DishShortDescriptionView.Props(dishName: "Some very big dish name with so many words",
                                                              difficulty: Dish.mock.difficulty,
                                                              totalTimeFull: Dish.mock.stringTotalTimeFull))
        }
        .previewLayout(.fixed(width: 343, height: 170))
    }
}

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
    
    private let mainStackView = UIStackView()
    private var gradientLayer: CAGradientLayer?
    private var renderedProps: Props?
            
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer?.frame = bounds
        
        mainStackView.axis = .vertical
        addSubview(mainStackView, withEdgeInsets: .zero)
    }
    
    public func render(props: Props) {
        
        if !props.isAllCornersRounded && props.isAllCornersRounded != renderedProps?.isAllCornersRounded {
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        
        if props.ingredients != renderedProps?.ingredients {
            mainStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            
            props.ingredients.forEach { ingredient in
                let singleIngredientView = SingleIngredientView(props: ingredient)
                let spaser = UIView()
                spaser.backgroundColor = R.color.grayUnmarked()?.withAlphaComponent(0.5)
                mainStackView.addArrangedSubview(singleIngredientView)
                if props.ingredients[props.ingredients.count - 1] != ingredient {
                    mainStackView.addArrangedSubview(spaser)
                }
                NSLayoutConstraint.activate([
                    singleIngredientView.heightAnchor.constraint(equalToConstant: 44),
                    spaser.heightAnchor.constraint(equalToConstant: 0.5)
                ])
            }
        }
        
        renderedProps = props
    }
    
    private func setupUI() {
        
        gradientLayer = apply(style: Styles.View.Gradient.muted)
        apply(style: Styles.View.CornerRadius.small)
        
        addSubview(mainStackView, withEdgeInsets: .zero)
    }
}

import SwiftUI
struct IngredientsViewPreview: PreviewProvider {
    
    static var previews: some View {
        ViewRepresentable(IngredientsView()) { view in
            view.render(
                props: IngredientsView.Props(
                    ingredients: [
                        SingleIngredientView.Props(name: "kjnvkj lfkm", amount: "2 pcs"),
                        SingleIngredientView.Props(name: "Wekvf", amount: "1 pcs"),
                        SingleIngredientView.Props(name: "Radicchio", amount: "1 pcs"),
                        SingleIngredientView.Props(name: "Cherry tomatoes", amount: "1 pcs"),
                        SingleIngredientView.Props(name: "Cucumber", amount: "1 pcs"),
                        SingleIngredientView.Props(name: "Chicken breast", amount: "200 g")
                    ]))
        }
        .previewLayout(.fixed(width: 343, height: 45 * 6 - 1))
    }
}

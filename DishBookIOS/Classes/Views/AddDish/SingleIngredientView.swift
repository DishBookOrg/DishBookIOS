//
//  SingleIngredientView.swift
//  DishBookIOS
//
//  Created by Anastasia Holovash on 14.06.2021.
//

import UIKit
import Combine

final class SingleIngredientView: UIView {
    
    struct Props {
        
        let name: String
        let amount: String
    }
    
    private let nameLabel = UILabel()
    private let amountLabel = UILabel()
    
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
    
    public func render(props: Props) {
        
        if props.name != renderedProps?.name {
            nameLabel.text = props.name
        }
        if props.amount != renderedProps?.amount {
            amountLabel.text = props.amount
        }
        
        renderedProps = props
    }
    
    private func setupUI() {
        backgroundColor = .clear
        
        nameLabel.font = R.font.sfProTextRegular(size: 17)
        nameLabel.textColor = R.color.textWhite()
        nameLabel.textAlignment = .left
        
        amountLabel.font = R.font.sfProTextRegular(size: 17)
        amountLabel.textColor = R.color.textWhite()
        amountLabel.textAlignment = .left
        
        let stackView = UIStackView(arrangedSubviews: [amountLabel, nameLabel])
        stackView.axis = .horizontal
        stackView.spacing = 16
        
        addSubview(stackView, withEdgeInsets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        NSLayoutConstraint.activate([
            amountLabel.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
}

import SwiftUI
struct SingleIngredientViewPreview: PreviewProvider {
    
    static var previews: some View {
        ViewRepresentable(SingleIngredientView()) { view in
            view.render(props: SingleIngredientView.Props(name: "Some name", amount: "200 pcs"))
            view.backgroundColor = R.color.primaryOrange()
        }
        .previewLayout(.fixed(width: 343, height: 44))
    }
}

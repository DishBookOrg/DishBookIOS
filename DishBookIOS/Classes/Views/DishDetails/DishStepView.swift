//
//  DishStepView.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 16.06.2021.
//

import UIKit
import Combine

final class DishStepView: UIView {
    
    // MARK: - Props
    
    typealias Props = Dish
    
    // MARK: - Private properties
    
    private let contentView = UIView()
    private let stackView = UIStackView()
    private let stepNumberLabel = UILabel()
    private let stepImageView = UIImageView()
    private let stepDescriptionLabel = UILabel()
    
    // MARK: - Lifecycle
    
    override func draw(_ rect: CGRect) {
        
        apply(style: Styles.View.CornerRadius.small)
        contentView.apply(style: Styles.View.Shadow.d20)
        stepImageView.apply(style: Styles.View.CornerRadius.small)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.layer.shadowPath = UIBezierPath(rect: contentView.bounds).cgPath
    }
    
    private func setupViews() {
        
        contentView.backgroundColor = R.color.textWhite()
        addSubview(contentView, withEdgeInsets: .zero)
        
        stackView.axis = .vertical
        stackView.spacing = 16
        
        contentView.addSubview(stackView, withEdgeInsets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        
        let stepNumberStackView = UIStackView()
        stepNumberStackView.spacing = 6
        
        let stepLeadingView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 2, height: 30)))
        stepLeadingView.layer.cornerRadius = 1
        stepLeadingView.backgroundColor = R.color.primaryOrange()
        stepNumberLabel.apply(style: Styles.Font.Rounded.SB.f2)
        stepNumberLabel.textColor = R.color.textBlack()
        
        stepNumberStackView.addArrangedSubview(stepLeadingView)
        stepNumberStackView.addArrangedSubview(stepNumberLabel)
        
        NSLayoutConstraint.activate([
            stepLeadingView.widthAnchor.constraint(equalToConstant: 2),
            stepImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        stepImageView.clipsToBounds = true
        stepImageView.contentMode = .scaleAspectFill
        
        stepDescriptionLabel.numberOfLines = 0
        stepDescriptionLabel.textColor = R.color.textBlack()
        stepDescriptionLabel.textAlignment = .center
        stepDescriptionLabel.apply(style: Styles.Font.Text.Regular.f5)
        
        stackView.addArrangedSubview(stepNumberStackView)
        stackView.addArrangedSubview(stepImageView)
        stackView.addArrangedSubview(stepDescriptionLabel)
    }
    
    public func render(props: Props) {
        
        stepNumberLabel.text = "Step 1"
        stepImageView.sd_setImage(with: props.imageReference)
        stepDescriptionLabel.text = "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga."
        
    }
}

// MARK: - Preview

import SwiftUI
struct DishStepViewPreview: PreviewProvider {
    
    static var previews: some View {
        ViewRepresentable(DishStepView()) { view in
            view.render(props: Dish.mock)
        }
        .previewLayout(.fixed(width: 343, height: 68))
    }
}

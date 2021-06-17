//
//  StepView.swift
//  DishBookIOS
//
//  Created by Anastasia Holovash on 16.06.2021.
//

import UIKit
import FirebaseUI

final class StepView: UIView {
    
    struct Props {
        let image: String?
        let stepNumber: Int
        let description: String
    }
    
    private let backgroundImageView = UIImageView()
    private let imageView = UIImageView()
    private let descriptionLabel = UILabel()
    private let titleLabel = UILabel()
    
    private let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
    
    private var renderedProps: Props?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    func render(props: Props) {
        
        if props.image != renderedProps?.image, let image = props.image {
            backgroundImageView.sd_setImage(with: image.imageReference)
            imageView.sd_setImage(with: image.imageReference)
        }
        if props.stepNumber != renderedProps?.stepNumber {
            titleLabel.text = "Step №\(props.stepNumber + 1)"
        }
        if props.description != renderedProps?.description {
            descriptionLabel.text = props.description
        }
    }
    
    private func setup() {
        apply(style: Styles.View.CornerRadius.small)
        clipsToBounds = true
        
        backgroundImageView.contentMode = .scaleAspectFill
        visualEffectView.layer.masksToBounds = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.apply(style: Styles.View.CornerRadius.d10)
        
        let separatorView = UIView()
        separatorView.backgroundColor = R.color.textDescriptionWhite()
        separatorView.apply(style: Styles.View.CornerRadius.d1)
        
        titleLabel.apply(style: Styles.Font.Rounded.SB.f4)
        titleLabel.textColor = R.color.textWhite()
        
        descriptionLabel.apply(style: Styles.Font.Text.Regular.f6)
        descriptionLabel.textColor = R.color.textWhite()
        descriptionLabel.numberOfLines = 0
        
        let labelsStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        labelsStackView.axis = .vertical
                
        let mainStackView = UIStackView(arrangedSubviews: [imageView, separatorView, labelsStackView])
        mainStackView.axis = .horizontal
        mainStackView.spacing = 6
        
        
        addSubview(backgroundImageView, withEdgeInsets: .zero)
        addSubview(visualEffectView, withEdgeInsets: .zero)
        
        addSubview(mainStackView, constraints: [
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            mainStackView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            separatorView.widthAnchor.constraint(equalToConstant: 2)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

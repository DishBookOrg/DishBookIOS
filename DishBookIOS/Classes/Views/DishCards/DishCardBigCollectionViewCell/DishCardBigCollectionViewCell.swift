//
//  DishCardBigCollectionViewCell.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 10.03.2021.
//

import UIKit
import FirebaseStorage
import FirebaseUI

final class DishCardBigCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    private let containerView = UIView()
    private let dishImageView = UIImageView()
    private let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
    
    private let dishNameLabel = UILabel()
    
    private let dishTimeLabel = UILabel()
    private let dishDifficultyLabel = UILabel()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = false
        contentView.clipsToBounds = false
        
        setupContainerView()
        setupDishImageView()
        setupVisualEffectView()
        setupDishNameLabel()
        setupDishTimeLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.apply(style: Styles.View.Shadow.d24)
    }
    
    private func setupContainerView() {
        
        addSubview(containerView, withEdgeInsets: .zero)
        containerView.clipsToBounds = false
        containerView.apply(style: Styles.View.Shadow.d24)
    }
    
    private func setupDishImageView() {
        
        containerView.addSubview(dishImageView, withEdgeInsets: .zero)
        dishImageView.contentMode = .scaleAspectFill
        dishImageView.clipsToBounds = true
        dishImageView.apply(style: Styles.View.CornerRadius.small)
    }
    
    private func setupVisualEffectView() {
        
        visualEffectView.layer.masksToBounds = false
        
        dishImageView.addSubview(visualEffectView, constraints: [
            
            visualEffectView.leadingAnchor.constraint(equalTo: dishImageView.leadingAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: dishImageView.trailingAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: dishImageView.bottomAnchor),
            visualEffectView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    private func setupDishNameLabel() {
        
        dishNameLabel.apply(style: Styles.Font.Rounded.SB.f4)
        dishNameLabel.textColor = .white
        
        visualEffectView.contentView.addSubview(dishNameLabel, constraints: [
            
            dishNameLabel.leadingAnchor.constraint(equalTo: visualEffectView.leadingAnchor, constant: 16),
            dishNameLabel.bottomAnchor.constraint(equalTo: visualEffectView.bottomAnchor, constant: -6),
            dishNameLabel.topAnchor.constraint(equalTo: visualEffectView.topAnchor, constant: 6)
        ])
    }
    
    private func setupDishTimeLabel() {
        
        dishDifficultyLabel.apply(style: Styles.Label.Difficulty.easy)
        dishTimeLabel.apply(style: Styles.Font.Rounded.Regular.f4)
        dishTimeLabel.textColor = .white
        
        dishTimeLabel.textAlignment = .center
        NSLayoutConstraint.activate([
            dishTimeLabel.widthAnchor.constraint(equalToConstant: 120),
            dishTimeLabel.heightAnchor.constraint(equalToConstant: 25),
            dishDifficultyLabel.widthAnchor.constraint(equalToConstant: 120),
            dishDifficultyLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        let trailingStackView = UIStackView(arrangedSubviews: [dishTimeLabel, dishDifficultyLabel])
        trailingStackView.axis = .vertical
        trailingStackView.alignment = .center
        
        visualEffectView.contentView.addSubview(trailingStackView, constraints: [
            
            trailingStackView.leadingAnchor.constraint(equalTo: dishNameLabel.trailingAnchor, constant: 6),
            trailingStackView.bottomAnchor.constraint(equalTo: visualEffectView.bottomAnchor, constant: -20),
            trailingStackView.widthAnchor.constraint(equalToConstant: 120),
            trailingStackView.topAnchor.constraint(equalTo: visualEffectView.topAnchor, constant: 20),
            trailingStackView.trailingAnchor.constraint(equalTo: visualEffectView.trailingAnchor, constant: -6)
        ])
    }
}

// MARK: - BindableCell

extension DishCardBigCollectionViewCell: BindableCell {
    
    typealias Props = Dish
    
    func render(props: Dish) {
        
        dishImageView.sd_setImage(with: props.imageReference, placeholderImage: R.image.placeholder())
        dishNameLabel.text = props.name
        dishTimeLabel.text = "􀐫 \(props.stringTotalTimeShort)"
        dishDifficultyLabel.text = props.difficulty.stringValue
        dishDifficultyLabel.textColor = props.difficulty.color
    }
}

// MARK: - Preview

import SwiftUI
struct DishCardBigCollectionViewCellPreview: PreviewProvider {
    
    static var previews: some View {
        ViewRepresentable(DishCardBigCollectionViewCell()) { view in
            view.render(props: DishCardBigCollectionViewCell.Props.mock)
        }
        .previewLayout(.fixed(width: 343, height: 500))
    }
}

//
//  DishCardBigCollectionViewCell.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 10.03.2021.
//

import UIKit

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
        
        containerView.apply(style: Styles.View.cardShadow16)
    }
    
    private func setupContainerView() {
        
        addSubview(containerView, withEdgeInsets: .zero)
        containerView.clipsToBounds = false
        containerView.apply(style: Styles.View.cardShadow16)
    }
    
    private func setupDishImageView() {
        
        containerView.addSubview(dishImageView, withEdgeInsets: .zero)
        dishImageView.contentMode = .scaleAspectFill
        dishImageView.clipsToBounds = true
        dishImageView.apply(style: Styles.View.cornerRadius20)
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
        
        dishNameLabel.apply(style: Styles.Label.roundedSB4)
        dishNameLabel.textColor = .white
        
        visualEffectView.contentView.addSubview(dishNameLabel, constraints: [
            
            dishNameLabel.leadingAnchor.constraint(equalTo: visualEffectView.leadingAnchor, constant: 16),
            dishNameLabel.bottomAnchor.constraint(equalTo: visualEffectView.bottomAnchor, constant: -6),
            dishNameLabel.topAnchor.constraint(equalTo: visualEffectView.topAnchor, constant: 6)
        ])
    }
    
    private func setupDishTimeLabel() {
        
        dishDifficultyLabel.apply(style: Styles.Label.easyDifficult)
        dishTimeLabel.apply(style: Styles.Label.roundedRegular6)
        dishTimeLabel.textColor = .white
        
        let smallConfiguration = UIImage.SymbolConfiguration(pointSize: 17, weight: .regular)
        let clockImage = UIImage(systemName: "clock", withConfiguration: smallConfiguration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let clockImageView = UIImageView(image: clockImage)
        
        NSLayoutConstraint.activate([
            clockImageView.widthAnchor.constraint(equalToConstant: 17),
            clockImageView.heightAnchor.constraint(equalToConstant: 17),
            dishTimeLabel.widthAnchor.constraint(equalToConstant: 43),
            dishTimeLabel.heightAnchor.constraint(equalToConstant: 25),
            dishDifficultyLabel.widthAnchor.constraint(equalToConstant: 60),
            dishDifficultyLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        let timeStackView = UIStackView(arrangedSubviews: [clockImageView, dishTimeLabel])
        timeStackView.axis = .horizontal
        timeStackView.alignment = .center
        timeStackView.spacing = 2
        
        let trailingStackView = UIStackView(arrangedSubviews: [timeStackView, dishDifficultyLabel])
        trailingStackView.axis = .vertical
        trailingStackView.alignment = .fill
        
        visualEffectView.contentView.addSubview(trailingStackView, constraints: [
            
            trailingStackView.leadingAnchor.constraint(equalTo: dishNameLabel.trailingAnchor, constant: 6),
            trailingStackView.bottomAnchor.constraint(equalTo: visualEffectView.bottomAnchor, constant: -20),
            trailingStackView.topAnchor.constraint(equalTo: visualEffectView.topAnchor, constant: 20),
            trailingStackView.trailingAnchor.constraint(equalTo: visualEffectView.trailingAnchor, constant: -6)
        ])
    }
}

// MARK: - BindableCell

extension DishCardBigCollectionViewCell: BindableCell {
    
    typealias Props = Dish
    
    func render(props: Dish) {
        
        dishImageView.image = props.image
        dishNameLabel.text = props.dishName
        dishTimeLabel.text = "\(props.time) min"
        dishDifficultyLabel.text = "Easy"
    }
}

// MARK: - Preview

import SwiftUI
struct DishCardBigCollectionViewCellPreview: PreviewProvider {
    
    static var previews: some View {
        ViewRepresentable(DishCardBigCollectionViewCell()) { view in
            view.render(props: DishCardBigCollectionViewCell.Props(dishName: "Some veryyyy big funcking dish  dish", time: 15))
        }
        .previewLayout(.fixed(width: 343, height: 500))
    }
}

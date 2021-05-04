//
//  DishCardSmallCollectionViewCell.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 10.03.2021.
//

import UIKit

final class DishCardSmallCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    private let containerView = UIView()
    private let dishImageView = UIImageView()
    private let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
    
    private let dishNameLabel = UILabel()
    private let dishTimeLabel = UILabel()
    
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
            visualEffectView.heightAnchor.constraint(equalToConstant: 67)
        ])
    }
    
    private func setupDishNameLabel() {
        
        dishNameLabel.apply(style: Styles.Label.roundedSB4)
        dishNameLabel.textColor = .white
        
        visualEffectView.contentView.addSubview(dishNameLabel, constraints: [
            
            dishNameLabel.leadingAnchor.constraint(equalTo: visualEffectView.leadingAnchor, constant: 6),
            dishNameLabel.bottomAnchor.constraint(equalTo: visualEffectView.bottomAnchor, constant: -2),
            dishNameLabel.topAnchor.constraint(equalTo: visualEffectView.topAnchor, constant: 2)
        ])
    }
    
    private func setupDishTimeLabel() {
        
        dishTimeLabel.apply(style: Styles.Label.roundedRegular6)
        dishTimeLabel.textColor = .white
        
        let smallConfiguration = UIImage.SymbolConfiguration(pointSize: 14, weight: .regular)
        let clockImage = UIImage(systemName: "clock", withConfiguration: smallConfiguration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        let clockImageView = UIImageView(image: clockImage)
        NSLayoutConstraint.activate([
            clockImageView.widthAnchor.constraint(equalToConstant: 15),
            clockImageView.heightAnchor.constraint(equalToConstant: 15)
        ])
        
        NSLayoutConstraint.activate([
            dishTimeLabel.widthAnchor.constraint(equalToConstant: 48),
            dishTimeLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
        
        let nestedStackView = UIStackView(arrangedSubviews: [clockImageView, dishTimeLabel])
        nestedStackView.axis = .horizontal
        nestedStackView.alignment = .center
        nestedStackView.spacing = 2
        
        visualEffectView.contentView.addSubview(nestedStackView, constraints: [
            nestedStackView.leadingAnchor.constraint(equalTo: dishNameLabel.trailingAnchor, constant: 6),
            nestedStackView.bottomAnchor.constraint(equalTo: visualEffectView.bottomAnchor, constant: 2),
            nestedStackView.topAnchor.constraint(equalTo: visualEffectView.topAnchor, constant: 2),
            nestedStackView.trailingAnchor.constraint(equalTo: visualEffectView.trailingAnchor, constant: -2)
        ])
    }
}

// MARK: - BindableCell

extension DishCardSmallCollectionViewCell: BindableCell {
    
    typealias Props = Dish
    
    func render(props: Dish) {
        
        dishImageView.image = props.image
        dishNameLabel.text = props.dishName
        dishTimeLabel.text = "\(props.time) min"
    }
}

// MARK: - Preview

import SwiftUI
struct DishCardSmallCollectionViewCellPreview: PreviewProvider {
    
    
    static var previews: some View {
        ViewRepresentable(DishCardSmallCollectionViewCell()) { view in
            view.render(props: DishCardSmallCollectionViewCell.Props(dishName: "Some dish", time: 15))
        }
        .previewLayout(.fixed(width: 190, height: 250))
    }
}

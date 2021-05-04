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
    private let dishNameLabel = UILabel()
    private let dishTimeLabel = UILabel()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = false
        contentView.clipsToBounds = false
        containerView.clipsToBounds = false
        
        addSubview(containerView, withEdgeInsets: .zero)
        containerView.apply(style: Styles.View.testRedShadow)
        
        setupDishImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        containerView.apply(style: Styles.View.testRedShadow)

//        containerView.apply(style: Styles.View.smallCornerRadius)

//        apply(style: Styles.View.smallCornerRadius)
//        dishImageView.apply(style: Styles.View.smallCornerRadius)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        setup()
    }
    
//    private func setup() {
//
//        let smallConfiguration = UIImage.SymbolConfiguration(pointSize: 14, weight: .regular)
//        let clockImage = UIImage(systemName: "clock", withConfiguration: smallConfiguration)
//        clockImageView.image = clockImage
//        visualEffectView.layer.masksToBounds = false
//    }
    
    private func setupDishImageView() {
        
        containerView.addSubview(dishImageView, withEdgeInsets: .zero)
        dishImageView.clipsToBounds = true
        dishImageView.apply(style: Styles.View.smallCornerRadius)
    }
}
 
// MARK: - BindableCell

extension DishCardSmallCollectionViewCell: BindableCell {
    
    typealias Props = Dish
    
    func render(props: Dish) {
        
        dishImageView.image = props.image
//        dishNameLabel.text = props.dishName
//        dishTimeLabel.text = "\(props.time) min"
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

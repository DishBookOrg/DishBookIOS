//
//  DishCardBigCollectionViewCell.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 10.03.2021.
//

import UIKit

final class DishCardBigCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var clockImageView: UIImageView!
    @IBOutlet weak var dishTimeLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    private func setup() {
        
        let smallConfiguration = UIImage.SymbolConfiguration(pointSize: 14, weight: .regular)
        let clockImage = UIImage(systemName: "clock", withConfiguration: smallConfiguration)
        clockImageView.image = clockImage
        visualEffectView.layer.masksToBounds = false
    }
    
    func configure(with model: Dish) {
        
        dishImageView.image = model.image
        dishNameLabel.text = model.dishName
        dishTimeLabel.text = "\(model.time) min"
    }
}

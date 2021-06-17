//
//  ImagePickerView.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 17.06.2021.
//

import UIKit
import Combine

final class ImagePickerView: ShadowedView {
    
    
    let pickerButton = UIButton()
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.image = R.image.videoFill()
        imageView.contentMode = .center
        imageView.apply(style: Styles.View.CornerRadius.small)
        
        addSubview(imageView, withEdgeInsets: .zero)
        addSubview(pickerButton, withEdgeInsets: .zero)
    }
    
    func setImage(_ image: UIImage) {
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
    }
}

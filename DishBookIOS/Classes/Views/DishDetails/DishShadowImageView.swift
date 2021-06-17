//
//  DishShadowImageView.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 16.06.2021.
//

import UIKit
import FirebaseStorage

final class DishShadowImageView: UIView {
    
    // MARK: - Props
    
    typealias Props = StorageReference
    
    // MARK: - Private properties
    
    private let dishImageView = UIImageView()
    
    // MARK: - Lifecycle
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        apply(style: Styles.View.CornerRadius.small)
        apply(style: Styles.View.Shadow.d20)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        dishImageView.clipsToBounds = true
        dishImageView.contentMode = .scaleAspectFill
        addSubview(dishImageView, withEdgeInsets: .zero)
    }
    
    public func render(props: Props) {
        
        dishImageView.sd_setImage(with: props)
    }
}

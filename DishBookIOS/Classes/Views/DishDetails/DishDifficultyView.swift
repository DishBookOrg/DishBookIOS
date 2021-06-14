//
//  DishDifficultyView.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 14.06.2021.
//

import UIKit

final class DishDifficultyView: UIView {
    
    // MARK: - Props
    
    typealias Props = Dish.Difficulty
    
    // MARK: - Constants
    
    struct Constants {
        static var stageWidth: CGFloat = 7
        static var stageHeight: CGFloat = 8
        static var stageSpacing: CGFloat = 4
    }
    
    // MARK: - Private properties
    
    private var firstStageView = UIView()
    private var secondStageView = UIView()
    private var thirdStageView = UIView()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupViews()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: Constants.stageWidth * 3 + Constants.stageSpacing * 2),
            heightAnchor.constraint(equalToConstant: Constants.stageHeight * 3)
        ])
        
        let subViews = [firstStageView, secondStageView, thirdStageView]
        subViews.forEach { view in
            
            // TODO: Check colors with design
            view.backgroundColor = R.color.grayUnmarked()
            view.apply(style: Styles.View.CornerRadius.d3)
        }
        
        addSubview(firstStageView, constraints: [
            
            firstStageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            firstStageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            firstStageView.widthAnchor.constraint(equalToConstant: Constants.stageWidth),
            firstStageView.heightAnchor.constraint(equalToConstant: Constants.stageHeight)
        ])
        
        addSubview(secondStageView, constraints: [
            
            secondStageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            secondStageView.leadingAnchor.constraint(equalTo: firstStageView.trailingAnchor, constant: Constants.stageSpacing),
            secondStageView.widthAnchor.constraint(equalToConstant: Constants.stageWidth),
            secondStageView.heightAnchor.constraint(equalToConstant: Constants.stageHeight * 2)
        ])
        
        addSubview(thirdStageView, constraints: [
            
            thirdStageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            thirdStageView.leadingAnchor.constraint(equalTo: secondStageView.trailingAnchor, constant: Constants.stageSpacing),
            thirdStageView.widthAnchor.constraint(equalToConstant: Constants.stageWidth),
            thirdStageView.heightAnchor.constraint(equalToConstant: Constants.stageHeight * 3)
        ])
    }
    
    private func getStageColor(props: Props) -> UIColor {
        
        switch props {
        case .easy:
            return R.color.primaryGreen()!
        case .medium:
            return R.color.primaryOrange()!
        case .hard:
            return R.color.primaryRed()!
        }
    }
    
    public func render(props: Props) {
        
        let views: [UIView]
        
        switch props {
        case .easy:
            views = [firstStageView]
            
        case .medium:
            views = [firstStageView, secondStageView]
            
        case .hard:
            views = [firstStageView, secondStageView, thirdStageView]
        }
        
        let stageColor = getStageColor(props: props)
        views.forEach { $0.backgroundColor = stageColor }
    }
}

// MARK: - Preview

import SwiftUI
struct DishDifficultyViewPreview: PreviewProvider {
    
    static var previews: some View {
        ViewRepresentable(DishDifficultyView()) { view in
            view.render(props: Dish.mock.difficulty)
        }
    }
}

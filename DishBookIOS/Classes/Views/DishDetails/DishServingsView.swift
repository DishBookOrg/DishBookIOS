//
//  DishServingsView.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 16.06.2021.
//

import UIKit

final class DishServingsView: UIView {
    
    // MARK: - Props
    
    typealias Props = Dish
    
    // MARK: - Private properties
    
    private let stackView = UIStackView()
    private let stepperView = StepperView()
    private let separatorView = UIView()
    
    // MARK: - Lifecycle
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        apply(style: Styles.View.Gradient.muted)
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
        
        stackView.axis = .vertical
        addSubview(stackView, withEdgeInsets: .zero)
        
        separatorView.backgroundColor = R.color.textWhite()

        // TODO: Change to ingredients view
        let emptyView = UIView()
        emptyView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            stepperView.heightAnchor.constraint(equalToConstant: 85),
            separatorView.heightAnchor.constraint(equalToConstant: 2),
            emptyView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        stackView.addArrangedSubview(stepperView)
        stackView.addArrangedSubview(separatorView)
        stackView.addArrangedSubview(emptyView)
    }
    
    public func render(props: Props) {
        
        stepperView.render(props: StepperView.Props(initialValue: 4, isAllCornersRounded: false))
    }
}

// MARK: - Preview

import SwiftUI
struct DishServingsViewPreview: PreviewProvider {
    
    static var previews: some View {
        ViewRepresentable(DishServingsView()) { view in
            view.render(props: DishServingsView.Props.mock)
        }
        .previewLayout(.sizeThatFits)
    }
}

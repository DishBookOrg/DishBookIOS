//
//  DishStepsCollapseView.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 16.06.2021.
//

import UIKit
import Combine

final class DishStepsCollapseView: UIView {
    
    // MARK: - Props
    
    typealias Props = Int
    
    // MARK: - Private properties
    
    private let stepsLabel = UILabel()
    private let stepsCountLabel = UILabel()
    private let dropDownButton = UIButton()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Private properties
    
    @Published var isOpened: Bool = false
    
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
        
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.spacing = 6
        
        addSubview(stackView, withEdgeInsets: UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24))
        
        stepsLabel.text = R.string.dishDetail.stepsLabel()
        stepsLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
        
        stepsLabel.apply(style: Styles.Font.Rounded.SB.f3)
        stepsLabel.textColor = R.color.textWhite()
        
        stepsCountLabel.apply(style: Styles.Font.Rounded.Medium.f4)
        stepsCountLabel.textColor = R.color.textWhite()
        
        let image = UIImage(systemName: "chevron.forward")?.withTintColor(R.color.textWhite()!, renderingMode: .alwaysOriginal)
        dropDownButton.setImage(image,
                                for: .normal)
        dropDownButton.setTitleColor(R.color.textWhite(), for: .normal)
        dropDownButton
            .publisher(for: .touchUpInside)
            .sink { [unowned self] _ in
                UIView.animate(withDuration: 0.35) { [self] in
                    dropDownButton.transform = CGAffineTransform(rotationAngle: isOpened ? 0 : CGFloat.pi / 2)
                }
                isOpened.toggle()
            }
            .store(in: &cancellables)
        
        NSLayoutConstraint.activate([
            dropDownButton.widthAnchor.constraint(equalToConstant: 44)
        ])
        
        stackView.addArrangedSubview(stepsLabel)
        stackView.addArrangedSubview(stepsCountLabel)
        stackView.addArrangedSubview(dropDownButton)
    }
    
    public func render(props: Props) {
        
        stepsCountLabel.text = "\(props)"
    }
}

// MARK: - Preview

import SwiftUI
struct DishStepsCollapseViewPreview: PreviewProvider {
    
    static var previews: some View {
        ViewRepresentable(DishStepsCollapseView()) { view in
            view.render(props: 1)
        }
        .previewLayout(.fixed(width: 343, height: 68))
    }
}

//
//  NewIngredientViewController.swift
//  DishBookIOS
//
//  Created by Anastasia Holovash on 16.06.2021.
//

import UIKit
import Combine

final class NewIngredientViewController: BaseViewController {
        
    // MARK: - Private properties
    
    private var viewModel: NewIngredientViewModel
    
    private let nameTextField = TextFieldWithDescription()
    private let amountTextField = TextFieldCentered()
    private let unitTextField = TextFieldCentered()
    private let scrollView = UIScrollView()
    private let amountUnitBackgroundView = GradientView()
    private let doneButton = UIButton()
    private let backButton = UIButton()
        
    private var ingredient = IngredientsAndSteps.Ingredient(ingredientName: "", ingredientType: "", ingredientAmount: 0)
        
    // MARK: - Lifecycle
    
    init(viewModel: NewIngredientViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil, closableCoordinator: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupStreams()
    }
    
    private func setup() {
        
        doneButton.setTitle("Done", for: .normal)
        doneButton.titleLabel?.apply(style: Styles.Font.Text.SB.f5) 
        doneButton.setTitleColor(R.color.textBlack(), for: .normal)
        backButton.setImage(R.image.back(), for: .normal)
        
        let navigationStack = UIStackView(arrangedSubviews: [backButton, UIView(), doneButton])
        
        let titleLabel = UILabel()
        titleLabel.apply(style: Styles.Font.Rounded.Medium.f2)
        titleLabel.textColor = R.color.textBlack()
        titleLabel.text = "New ingredient"

        nameTextField.setup(placeholder: "Name", description: "Start entering the name of the ingredient.")
        amountTextField.setup(placeholder: "0", description: "Amount")
        unitTextField.setup(placeholder: "g", description: "Unit")
        
        let amountUnitStackView = UIStackView(arrangedSubviews: [amountTextField, unitTextField])
        amountUnitStackView.axis = .horizontal
        amountUnitStackView.spacing = 20
        amountUnitStackView.distribution = .fillEqually
        
        amountUnitBackgroundView.addSubview(amountUnitStackView, withEdgeInsets: UIEdgeInsets(top: 24, left: 8, bottom: 24, right: 8))
        
        NSLayoutConstraint.activate([
            amountUnitBackgroundView.heightAnchor.constraint(equalToConstant: 108),
            nameTextField.heightAnchor.constraint(equalToConstant: 60),
            navigationStack.heightAnchor.constraint(equalToConstant: 44),
            backButton.widthAnchor.constraint(equalToConstant: 44)
        ])
        
        let mainStackView = UIStackView(arrangedSubviews: [navigationStack, titleLabel, nameTextField, amountUnitBackgroundView])
        
        mainStackView.axis = .vertical
        mainStackView.spacing = 60
        mainStackView.setCustomSpacing(0, after: navigationStack)
        
        view.addSubview(mainStackView, constraints: [
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupStreams() {
        
        nameTextField.didChangeTextPublisher
            .sink { [unowned self] in ingredient.ingredientName = $0 }
            .store(in: &cancelableSet)
        
        amountTextField.didChangeTextPublisher
            .sink { [unowned self] in ingredient.ingredientAmount = Float($0) ?? 0 }
            .store(in: &cancelableSet)
        
        unitTextField.didChangeTextPublisher
            .sink { [unowned self] in ingredient.ingredientType = $0 }
            .store(in: &cancelableSet)
        
        doneButton.publisher(for: .touchUpInside)
            .sink { [unowned self] _ in viewModel.didPressDoneSubject.send((ingredient)) }
            .store(in: &cancelableSet)
        
        backButton.publisher(for: .touchUpInside)
            .sink { [unowned self] _ in viewModel.didPressBackSubject.send(()) }
            .store(in: &cancelableSet)
    }
}

import SwiftUI
struct IngredientPreview: PreviewProvider {

    static var previews: some View {
        ViewRepresentable(NewIngredientViewController(viewModel: NewIngredientViewModel()).view)
    }
}

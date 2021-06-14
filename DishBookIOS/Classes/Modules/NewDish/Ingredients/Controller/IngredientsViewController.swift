//
//  IngredientsViewController.swift
//  DishBookIOS
//
//  Created by Anastasia Holovash on 14.06.2021.
//

import UIKit
import Combine

final class IngredientsViewController: BaseViewController {
        
    // MARK: - Private properties
    
    private var viewModel: IngredientsViewModel
    
    private let ingredientsView = IngredientsView()
    private let scrollView = UIScrollView()
    private let addIngredientButton = UIButton()
        
    // MARK: - Lifecycle
    
    init(viewModel: IngredientsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil, closableCoordinator: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupNavigationBar()
        setupStreams()
    }
    
    func render(ingredients: [NewDish.IngredientsAndSteps.Ingredient]) {
        let ingredientsProps = ingredients.map { SingleIngredientView.Props(name: $0.ingredientName, amount: "\($0.ingredientAmount) \($0.ingredientType)") }
        
        ingredientsView.render(props: IngredientsView.Props(ingredients: ingredientsProps))
    }
    
    private func setup() {
        
        let progressBarView = UIImageView(image: R.image.progressBar())
        let titleLabel = UILabel()
        titleLabel.apply(style: Styles.Font.Rounded.Medium.f2)
        titleLabel.textColor = R.color.textBlack()
        titleLabel.text = "Ingredients"
        
        scrollView.addSubview(ingredientsView, withEdgeInsets: .zero)
        scrollView.contentInset.bottom = 94
        
        let mainStackView = UIStackView(
            arrangedSubviews: [progressBarView, titleLabel, scrollView])
        mainStackView.axis = .vertical
        mainStackView.spacing = 24
        mainStackView.setCustomSpacing(30, after: progressBarView)
        
        let addIngredientView = UIImageView(image: R.image.addNew())
        
        view.addSubview(mainStackView, withEdgeInsets: UIEdgeInsets(top: view.safeAreaInsets.top + 24, left: 16, bottom: 0, right: 16))
        
        view.addSubview(addIngredientView, constraints: [
            addIngredientView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addIngredientView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            addIngredientView.heightAnchor.constraint(equalToConstant: 44),
            addIngredientView.widthAnchor.constraint(equalToConstant: 44)
        ])
        
        addIngredientView.addSubview(addIngredientButton, withEdgeInsets: .zero)
    }
    
    private func setupStreams() {
        
        addIngredientButton.publisher(for: .touchUpInside)
            .sink { [unowned self] _ in viewModel.didPressPlusSubject.send(())}
            .store(in: &cancelableSet)
    }
    
    private func setupNavigationBar() {
        
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(didPressNext))
        navigationItem.rightBarButtonItem = nextButton
    }
    
    @objc
    func didPressNext() {
        
        viewModel.didPressNextSubject.send(())
    }
}

import SwiftUI
struct IngredientsPreview: PreviewProvider {

    static var previews: some View {
        ViewRepresentable(IngredientsViewController(viewModel: IngredientsViewModel()).view)
    }
}

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
    
    func render(ingredients: [IngredientsAndSteps.Ingredient]) {
        let ingredientsProps = ingredients.map { SingleIngredientView.Props(name: $0.ingredientName, amount: "\($0.ingredientAmount) \($0.ingredientType)") }
        
        ingredientsView.render(props: IngredientsView.Props(ingredients: ingredientsProps))
    }
    
    private func setup() {
        
        let progressBarView = UIImageView(image: R.image.progressBarStep2())
        let titleLabel = UILabel()
        titleLabel.apply(style: Styles.Font.Rounded.Medium.f2)
        titleLabel.textColor = R.color.textBlack()
        titleLabel.text = "Ingredients"
        
        scrollView.addSubview(ingredientsView, withEdgeInsets: .zero)
        scrollView.contentInset.bottom = 60
        scrollView.clipsToBounds = true
        scrollView.apply(style: Styles.View.CornerRadius.small)
        scrollView.showsVerticalScrollIndicator = false
        
        let mainStackView = UIStackView(
            arrangedSubviews: [progressBarView, titleLabel])
        mainStackView.axis = .vertical
        mainStackView.spacing = 24
        mainStackView.setCustomSpacing(30, after: progressBarView)
        mainStackView.backgroundColor = R.color.textWhite()
        
        let addIngredientView = UIImageView(image: R.image.addNew())
        
        view.addSubview(mainStackView, constraints: [
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        view.addSubview(scrollView, constraints: [
            scrollView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 24),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            ingredientsView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32)
        ])
        
        addIngredientView.isUserInteractionEnabled = true
        view.addSubview(addIngredientView, constraints: [
            addIngredientView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addIngredientView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            addIngredientView.heightAnchor.constraint(equalToConstant: 44),
            addIngredientView.widthAnchor.constraint(equalToConstant: 44)
        ])
        
        addIngredientView.addSubview(addIngredientButton, withEdgeInsets: .zero)
        view.sendSubviewToBack(scrollView)
    }
    
    private func setupStreams() {
        
        addIngredientButton.isUserInteractionEnabled = true
        addIngredientButton.publisher(for: .allEvents)
            .sink { [unowned self] _ in viewModel.didPressPlusSubject.send(()) }
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

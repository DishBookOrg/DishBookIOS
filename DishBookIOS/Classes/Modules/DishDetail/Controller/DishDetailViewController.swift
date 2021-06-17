//
//  DishDetailViewController.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 14.06.2021.
//

import UIKit
import FirebaseStorage

final class DishDetailViewController: BaseViewController {
    
    // MARK: - Private properties
    
    private var viewModel: DishDetailViewModel
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    private let dishImageView = DishShadowImageView()
    private let dishShortDescriptionView = DishShortDescriptionView()
    private let dishServingsView = DishServingsView()
    private let dishStepsCollapseView = DishStepsCollapseView()
    private let addToDishBookButton = GradientButton()
    private let highlightedButton = BlackButton()
    
    // MARK: - Lifecycle
    
    init(viewModel: DishDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil, closableCoordinator: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()

        setupViews()
        render(with: viewModel.dish)
    }
    
    private func setupViews() {
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        view.addSubview(scrollView, withEdgeInsets: .zero)
        scrollView.addSubview(stackView, withEdgeInsets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        
        stackView.axis = .vertical
        stackView.spacing = 24
        
        NSLayoutConstraint.activate([
            dishImageView.heightAnchor.constraint(equalToConstant: 400),
            dishStepsCollapseView.heightAnchor.constraint(equalToConstant: 68),
            addToDishBookButton.heightAnchor.constraint(equalToConstant: 68),
            highlightedButton.heightAnchor.constraint(equalToConstant: 68),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
        
        addToDishBookButton.setTitle(R.string.dishDetail.addToDishBookButton(), for: .normal)
        
        switch viewModel.type {
            case .explore, .dishBook:
                highlightedButton.setTitle(R.string.dishDetail.cookItButton(), for: .normal)
            case .newDish:
                highlightedButton.setTitle(R.string.dishDetail.publicateButton(), for: .normal)
        }
        
        stackView.clipsToBounds = false
        stackView.addArrangedSubview(dishImageView)
        stackView.addArrangedSubview(dishShortDescriptionView)
        stackView.addArrangedSubview(dishServingsView)
        stackView.addArrangedSubview(dishStepsCollapseView)
        if viewModel.type == .explore {
            stackView.addArrangedSubview(addToDishBookButton)
        }
        stackView.addArrangedSubview(highlightedButton)
    }
    
    private func render(with dish: Dish) {
        
        if let ingredientsAndSteps = dish.ingredientsAndSteps {
            
            let ingredients = ingredientsAndSteps.ingredients.map { SingleIngredientView.Props(name: $0.ingredientName, amount: "\($0.ingredientAmount) \($0.ingredientType)") }
            
            dishServingsView.render(props: DishServingsView.Props(numberOfServings: dish.numberOfServings, ingredients: ingredients))
            dishStepsCollapseView.render(props: ingredientsAndSteps.steps.count)
            setupSteps(ingredientsAndSteps.steps)
            
            dishServingsView.showInStackView(animated: true)
            dishStepsCollapseView.showInStackView(animated: true)
            
        } else {
            dishServingsView.hideInStackView(animated: true)
            dishStepsCollapseView.hideInStackView(animated: true)
        }
        
        dishImageView.render(props: dish.imageReference)
        dishShortDescriptionView.render(props: DishShortDescriptionView.Props(dishName: dish.name,
                                                                              difficulty: dish.difficulty,
                                                                              totalTimeFull: dish.stringTotalTimeFull))
    }
    
    private func setupBindings() {
        
        dishServingsView
            .$numberOfServings
            .sink { [unowned self] numberOfServings in
                
                guard let newIngredints = viewModel.countNewIngredients(numberOfServings: numberOfServings) else {
                    return
                }
                dishServingsView.ingredientsView.render(props: IngredientsView.Props(ingredients: newIngredints, isAllCornersRounded: false))
            }
            .store(in: &cancelableSet)
        
        viewModel.$showLoader
            .assignNoRetain(to: \.showLoader, on: self)
            .store(in: &cancelableSet)
        
        viewModel.$dish
            .dropFirst()
            .sink { [unowned self] dish in
                render(with: dish)
            }
            .store(in: &cancelableSet)
        
        dishStepsCollapseView
            .$isOpened
            .sink { [unowned self] isOpenedSteps in
                isOpenedSteps ? showSteps() : hideSteps()
            }
            .store(in: &cancelableSet)
        
        highlightedButton
            .publisher(for: .touchUpInside)
            .sink { [unowned self] _ in viewModel.didPressPublicateSubject.send(()) }
            .store(in: &cancelableSet)
    }
    
    private func setupSteps(_ steps: [IngredientsAndSteps.Step]) {
        
        guard !stackView.arrangedSubviews.isEmpty else {
            return
        }
        
        var isHidden: Bool = true
        
        let dishStepViews = stackView.arrangedSubviews
            .filter { $0 is DishStepView }
        
        isHidden = dishStepViews.isEmpty
        
        dishStepViews
            .forEach { $0.removeFromSuperview() }
        
        steps.enumerated().forEach { index, step in
            
            let dishStepView = DishStepView()
            dishStepView.render(props: DishStepView.Props(number: index + 1,
                                                          imageReference: step.stepAttachmentURL.imageReference,
                                                          description: step.stepDescription))
            dishStepView.isHidden = isHidden
            stackView.insertArrangedSubview(dishStepView, at: 4 + index )
        }
    }
    
    private func showSteps(animated: Bool = true) {
        
        stackView.arrangedSubviews
            .filter { $0 is DishStepView }
            .forEach { $0.showInStackView(animated: animated) }
        
        if let firstDishStepFrame = stackView.arrangedSubviews.first(where: { $0 is DishStepView })?.frame {
            scrollView.scrollRectToVisible(firstDishStepFrame, animated: true)
        }
    }
    
    private func hideSteps(animated: Bool = true) {
        
        stackView.arrangedSubviews
            .filter { $0 is DishStepView }
            .forEach { $0.hideInStackView(animated: animated) }
    }
}

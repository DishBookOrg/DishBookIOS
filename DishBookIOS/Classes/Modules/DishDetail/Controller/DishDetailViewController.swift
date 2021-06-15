//
//  DishDetailViewController.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 14.06.2021.
//

import UIKit

final class DishDetailViewController: BaseViewController {
    
    // MARK: - Private properties
    
    private var viewModel: DishDetailViewModel
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    private let dishImageView = DishShadowImageView()
    private let dishShortDescriptionView = DishShortDescriptionView()
    private let dishServingsView = DishServingsView()
    private let dishStepsCollapseView = DishStepsCollapseView()
    
    // MARK: - Lifecycle
    
    init(viewModel: DishDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil, closableCoordinator: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        setupViews()
    }
    
    private func setupViews() {
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        view.addSubview(scrollView, withEdgeInsets: .zero)
        scrollView.addSubview(stackView, withEdgeInsets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        
        stackView.axis = .vertical
        stackView.spacing = 40
        
        NSLayoutConstraint.activate([
            dishImageView.heightAnchor.constraint(equalToConstant: 400),
            dishStepsCollapseView.heightAnchor.constraint(equalToConstant: 68),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
        
        stackView.clipsToBounds = false
        stackView.addArrangedSubview(dishImageView)
        stackView.addArrangedSubview(dishShortDescriptionView)
        stackView.addArrangedSubview(dishServingsView)
        stackView.addArrangedSubview(dishStepsCollapseView)
        
        generateSteps()
        hideSteps(animated: false)
    }
    
    private func render(with dish: Dish) {
        
        dishServingsView.render(props: dish)
        dishStepsCollapseView.render(props: 5)
        dishImageView.render(props: dish.imageReference)
        dishShortDescriptionView.render(props: DishShortDescriptionView.Props(dishName: dish.name,
                                                                              difficulty: dish.difficulty,
                                                                              totalTimeFull: dish.stringTotalTimeFull))
    }
    
    private func setupBindings() {
        
        viewModel.$showLoader
            .assignNoRetain(to: \.showLoader, on: self)
            .store(in: &cancelableSet)
        
        viewModel.$dish
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
    }
    
    private func generateSteps() {
        
        let view = DishStepView()
        view.render(props: viewModel.dish)
        stackView.insertArrangedSubview(view, at: 4)
        
        let view2 = DishStepView()
        view2.render(props: viewModel.dish)
        stackView.insertArrangedSubview(view2, at: 5)
        
        let view3 = DishStepView()
        view3.render(props: viewModel.dish)
        stackView.insertArrangedSubview(view3, at: 6)
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

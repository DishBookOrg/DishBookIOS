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
        
        view.addSubview(scrollView, withEdgeInsets: .zero)
        scrollView.addSubview(stackView, withEdgeInsets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        
        stackView.axis = .vertical
        stackView.spacing = 40
        
        NSLayoutConstraint.activate([
            dishImageView.heightAnchor.constraint(equalToConstant: 400),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
        
        stackView.clipsToBounds = false
        stackView.addArrangedSubview(dishImageView)
        stackView.addArrangedSubview(dishShortDescriptionView)
        stackView.addArrangedSubview(dishServingsView)
    }
    
    private func render(with dish: Dish) {
        
        dishServingsView.render(props: dish)
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
    }
}

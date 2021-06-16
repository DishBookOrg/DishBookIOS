//
//  CreateStepsViewController.swift
//  DishBookIOS
//
//  Created by Anastasia Holovash on 16.06.2021.
//

import UIKit
import Combine

final class CreateStepsViewController: BaseViewController {
        
    // MARK: - Private properties
    
    private var viewModel: CreateStepsViewModel
    
    private let stepsView = IngredientsView()
    private let scrollView = UIScrollView()
    private let addStepButton = UIButton()
        
    // MARK: - Lifecycle
    
    init(viewModel: CreateStepsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil, closableCoordinator: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupNavigationBar()
        setupStreams()
    }
    
    func render(steps: [NewDish.IngredientsAndSteps.Step]) {
//        let ingredientsProps = ingredients.map { SingleIngredientView.Props(name: $0.ingredientName, amount: "\($0.ingredientAmount) \($0.ingredientType)") }
//
//        ingredientsView.render(props: IngredientsView.Props(ingredients: ingredientsProps))
    }
    
    private func setup() {
        
        let progressBarView = UIImageView(image: R.image.progressBarStep3())
        let titleLabel = UILabel()
        titleLabel.apply(style: Styles.Font.Rounded.Medium.f2)
        titleLabel.textColor = R.color.textBlack()
        titleLabel.text = "Steps"
        
        scrollView.addSubview(stepsView, withEdgeInsets: .zero)
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
        
        let addStepView = UIImageView(image: R.image.addNew())
        
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
            stepsView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32)
        ])
        
        addStepView.isUserInteractionEnabled = true
        view.addSubview(addStepView, constraints: [
            addStepView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addStepView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            addStepView.heightAnchor.constraint(equalToConstant: 44),
            addStepView.widthAnchor.constraint(equalToConstant: 44)
        ])
        
        addStepView.addSubview(addStepButton, withEdgeInsets: .zero)
        view.sendSubviewToBack(scrollView)
    }
    
    private func setupStreams() {
        
        addStepButton.isUserInteractionEnabled = true
        addStepButton.publisher(for: .allEvents)
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
struct CreateStepsPreview: PreviewProvider {

    static var previews: some View {
        ViewRepresentable(CreateStepsViewController(viewModel: CreateStepsViewModel()).view)
    }
}


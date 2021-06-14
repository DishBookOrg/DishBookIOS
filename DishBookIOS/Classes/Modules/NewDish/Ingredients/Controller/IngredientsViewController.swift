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
    
    private let nameTextField = TextFieldWithDescription()
    private let ownPublicSegmentedControl = SegmentedControl()
    private let difficultySegmentedControl = SegmentedControl()
    private let stepperView = StepperView()
        
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
    
    private func setup() {
        
        let progressBarView = UIImageView(image: R.image.progressBar())
        
        nameTextField.setup(placeholder: R.string.newDish.textFieldNamePlaceholder(), description: R.string.newDish.textFieldNameDescription())
        ownPublicSegmentedControl.render(
            props: SegmentedControl.Props(
                segmentsNames: [Dish.Privacy.private, Dish.Privacy.public],
                descriptionText: R.string.newDish.segmentedControlPrivatePublicDescription()
            ))
        difficultySegmentedControl.render(
            props: SegmentedControl.Props(
                segmentsNames: [Dish.Difficulty.easy, Dish.Difficulty.medium, Dish.Difficulty.hard],
                descriptionText: R.string.newDish.segmentedControlDifficultyDescription()
            ))
        stepperView.render(props: StepperView.Props(initialValue: 4))
        
        let mainStackView = UIStackView(
            arrangedSubviews: [progressBarView, nameTextField, ownPublicSegmentedControl, difficultySegmentedControl, stepperView])
        mainStackView.axis = .vertical
        mainStackView.spacing = 60
        mainStackView.setCustomSpacing(30, after: progressBarView)
        
        view.addSubview(mainStackView, constraints: [
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameTextField.heightAnchor.constraint(equalToConstant: 60),
            ownPublicSegmentedControl.heightAnchor.constraint(equalToConstant: 57),
            difficultySegmentedControl.heightAnchor.constraint(equalToConstant: 57),
            stepperView.heightAnchor.constraint(equalToConstant: 85)
        ])
    }
    
    private func setupStreams() {
//        nameTextField.didChangeTextPublisher
//            .sink { [unowned self] in viewModel.didChangeNameSubject.send($0) }
//            .store(in: &cancelableSet)
        
    }
    
    private func setupNavigationBar() {
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(didPressNext))
        navigationItem.rightBarButtonItem = nextButton
    }
    
    @objc
    func didPressNext() {
//        viewModel.didPressNextSubject.send(())
    }
}

import SwiftUI
struct IngredientsPreview: PreviewProvider {

    static var previews: some View {
        ViewRepresentable(IngredientsViewController(viewModel: IngredientsViewModel()).view)
    }
}

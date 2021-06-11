//
//  NewDishViewController.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 02.02.2021.
//

import UIKit
import Combine

final class NewDishViewController: BaseViewController {
        
    // MARK: - Private properties
    
    private var viewModel: NewDishViewModel
    
    private let nameTextField = TextFieldWithDescription()
    private let ownPublicSegmentedControl = SegmentedControl()
    private let difficultySegmentedControl = SegmentedControl()
    private let stepperView = StepperView()
        
    // MARK: - Lifecycle
    
    init(viewModel: NewDishViewModel) {
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
        nameTextField.didChangeTextPublisher
            .sink { [unowned self] in viewModel.didChangeNameSubject.send($0) }
            .store(in: &cancelableSet)
        
        ownPublicSegmentedControl.didSelectPublisher
            .sink { [unowned self] in
                guard let privacy = $0 as? Dish.Privacy else { return }
                viewModel.didSelectPrivacyLevelSubject.send(privacy)
            }
            .store(in: &cancelableSet)
        
        difficultySegmentedControl.didSelectPublisher
            .sink { [unowned self] in
                guard let privacy = $0 as? Dish.Difficulty else { return }
                viewModel.didSelectDifficultyLevelSubject.send(privacy)
            }
            .store(in: &cancelableSet)
        
        stepperView.$currentStep
            .sink { [unowned self] in viewModel.didChangeNumberOfServingsSubject.send($0) }
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
struct NewDishViewPreview: PreviewProvider {

    static var previews: some View {
        ViewRepresentable(NewDishViewController(viewModel: NewDishViewModel()).view)
    }
}

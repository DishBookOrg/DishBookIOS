//
//  NewDishViewController.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 02.02.2021.
//

import UIKit

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
    }
    
    private func setup() {
        
        nameTextField.setup(placeholder: R.string.newDish.textFieldNamePlaceholder(), description: R.string.newDish.textFieldNameDescription())
        ownPublicSegmentedControl.render(
            props: SegmentedControl.Props(
                segmentsNames: [R.string.newDish.segmentedControlPrivate(), R.string.newDish.segmentedControlPublic()],
                descriptionText: R.string.newDish.segmentedControlPrivatePublicDescription()
            ))
        difficultySegmentedControl.render(
            props: SegmentedControl.Props(
                segmentsNames: [
                    R.string.newDish.segmentedControlDifficultyEasy(),
                    R.string.newDish.segmentedControlDifficultyMedium(),
                    R.string.newDish.segmentedControlDifficultyHard()],
                descriptionText: R.string.newDish.segmentedControlDifficultyDescription()
            ))
        stepperView.render(props: StepperView.Props(initialValue: 4))
        
        let mainStackView = UIStackView(
            arrangedSubviews: [nameTextField, ownPublicSegmentedControl, difficultySegmentedControl, stepperView])
        mainStackView.axis = .vertical
        mainStackView.spacing = 60
        
        view.addSubview(mainStackView, constraints: [
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 74),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameTextField.heightAnchor.constraint(equalToConstant: 60),
            ownPublicSegmentedControl.heightAnchor.constraint(equalToConstant: 57),
            difficultySegmentedControl.heightAnchor.constraint(equalToConstant: 57),
            stepperView.heightAnchor.constraint(equalToConstant: 85)
        ])
    }
}

import SwiftUI
struct NewDishViewPreview: PreviewProvider {

    static var previews: some View {
        ViewRepresentable(NewDishViewController(viewModel: NewDishViewModel()).view)
    }
}

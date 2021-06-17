//
//  NewStepViewController.swift
//  DishBookIOS
//
//  Created by Anastasia Holovash on 16.06.2021.
//

import UIKit
import Combine

final class NewStepViewController: BaseViewController {
    
    // MARK: - Private properties
    
    private var viewModel: NewStepViewModel
    
    private let imagePickerView = ImagePickerView()
    private let imagePicker = ImagePicker(type: .image)
    
    private let textView = UITextView()
    private let datePicker = UIDatePicker()
    private let doneButton = UIButton()
    private let backButton = UIButton()
    
    // MARK: - Lifecycle
    
    init(viewModel: NewStepViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil, closableCoordinator: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupStreams()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        textView.placeholderText = "Type a description for this step."
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
        titleLabel.text = "Step №\(viewModel.stepNumber)"
        
        textView.font = R.font.sfProTextRegular(size: 17)
        
        let textViewBackgroundView = ShadowedView()
        textViewBackgroundView.addSubview(textView, withEdgeInsets: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
        
        let datePickerBackgroundView = ShadowedView()
        datePicker.datePickerMode = .countDownTimer
        datePicker.minuteInterval = 5
        datePickerBackgroundView.addSubview(datePicker, withEdgeInsets: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
        
        imagePickerView.pickerButton
            .publisher(for: .touchUpInside)
            .sink { [unowned self] _ in addImage() }
            .store(in: &cancelableSet)
        
        let mainStackView = UIStackView(arrangedSubviews: [navigationStack, titleLabel, imagePickerView, textViewBackgroundView, datePickerBackgroundView])
        
        mainStackView.axis = .vertical
        mainStackView.spacing = 24
        mainStackView.setCustomSpacing(0, after: navigationStack)
        
        view.addSubview(mainStackView, constraints: [
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textViewBackgroundView.heightAnchor.constraint(equalToConstant: 150),
            datePickerBackgroundView.heightAnchor.constraint(equalToConstant: 150),
            imagePickerView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func addImage() {
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
            self?.showMediaPicker(with: .camera)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default) { [weak self] _ in
            self?.showMediaPicker(with: .photoLibrary)
        }
        
        let closeAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        AlertManager.showAlert(withTitle: "Add image",
                               actions: [cameraAction, photoLibraryAction, closeAction],
                               style: .actionSheet)
    }
    
    private func showMediaPicker(with sourceType: UIImagePickerController.SourceType) {
        
        imagePicker
            .presentInViewController(self, isEditable: true, sourceType: sourceType) { [weak self] result in
                
                switch result {
                case .success(let originalImage, let editedImage, _, let picker):
                    
                    let image = editedImage != nil ? editedImage! : originalImage
                    self?.imagePickerView.setImage(image)
                    self?.viewModel.loadImage(image)
                    picker.dismiss(animated: true, completion: nil)
                default:
                    return
                }
            }
    }
    
    private func setupStreams() {
        
        textView.textPublisher
            .sink { [unowned self] in viewModel.step.stepDescription = $0 }
            .store(in: &cancelableSet)
        
        doneButton.publisher(for: .touchUpInside)
            .sink { [unowned self] _ in
                step.stepTime = Int(datePicker.countDownDuration)
                viewModel.didPressDoneSubject.send((step))
            }
            .store(in: &cancelableSet)
        
        backButton.publisher(for: .touchUpInside)
            .sink { [unowned self] _ in viewModel.didPressBackSubject.send(()) }
            .store(in: &cancelableSet)
        
        viewModel.$showLoader
            .assignNoRetain(to: \.showLoader, on: self)
            .store(in: &cancelableSet)
    }
}

import SwiftUI
struct StepPreview: PreviewProvider {
    
    static var previews: some View {
        ViewRepresentable(NewStepViewController(viewModel: NewStepViewModel(stepNumber: 3, step: IngredientsAndSteps.Step(stepDescription: "", stepAttachmentURL: "", stepTime: 1))).view)
    }
}

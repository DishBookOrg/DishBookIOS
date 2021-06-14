//
//  NewDishCoordinator.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 02.02.2021.
//

import UIKit
import Combine

final class NewDishCoordinator: BaseRootCoordinator {
    
    private var newDish = NewDish()

    override init() {
        super.init()
        
        self.tabItem = UITabBarItem(title: R.string.common.new(),
                                    image: R.image.plus(),
                                    selectedImage: R.image.plus()?.withTintColor(R.color.primaryOrangeMuted()!,
                                                                                 renderingMode: .alwaysOriginal))
        navigationController?.isNavigationBarHidden = false
        start()
    }
    
    override func start() {
        
        let firstStepViewController = createFirstStep()
        navigationController?.pushViewController(firstStepViewController, animated: false)
    }
    
    private func createFirstStep() -> UIViewController {
        
        let viewModel = FirstStepViewModel()

        viewModel.didChangeNamePublisher
            .sink { [unowned self] in newDish.name = $0 }
            .store(in: &cancelableSet)
        
        viewModel.didSelectPrivacyLevelPublisher
            .sink { [unowned self] in newDish.privacy = $0 }
            .store(in: &cancelableSet)
        
        viewModel.didSelectDifficultyLevelPublisher
            .sink { [unowned self] in newDish.difficulty = $0 }
            .store(in: &cancelableSet)
        
        viewModel.didChangeNumberOfServingsPublisher
            .sink { _ in }
            .store(in: &cancelableSet)
        
        viewModel.didPressNextPublisher
            .sink { [unowned self] in
                let secondStepViewController = createSecondStep()
                navigationController?.pushViewController(secondStepViewController, animated: true)
            }
            .store(in: &cancelableSet)

        return FirstStepViewController(viewModel: viewModel)
    }
    
    private func createSecondStep() -> UIViewController {        
        let vc = UIViewController()
        vc.view.backgroundColor = .systemBackground
        return vc
    }
    
}

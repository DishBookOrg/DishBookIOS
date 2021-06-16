//
//  NewDishCoordinator.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 02.02.2021.
//

import UIKit
import Combine

final class NewDishCoordinator: BaseRootCoordinator {
    
    // MARK: - Variables
    
    private var newDish = NewDish()
    private var ingredientsAndSteps = NewDish.IngredientsAndSteps(ingredients: [
        NewDish.IngredientsAndSteps.Ingredient(ingredientName: "Name Name Name", ingredientType: "g", ingredientAmount: 350),
        NewDish.IngredientsAndSteps.Ingredient(ingredientName: "Some", ingredientType: "kg", ingredientAmount: 0.5),
        NewDish.IngredientsAndSteps.Ingredient(ingredientName: "Name Name Name2", ingredientType: "g", ingredientAmount: 350),
        NewDish.IngredientsAndSteps.Ingredient(ingredientName: "Some3", ingredientType: "kg", ingredientAmount: 0.5)
    ], steps: [
        NewDish.IngredientsAndSteps.Step(stepDescription: "venenatis blandit consequat. Donec quis vulputate arcu. Fusce augue n", stepAttachmentURL: "", stepTime: 120),
        NewDish.IngredientsAndSteps.Step(stepDescription: "et, consectetur adipiscing elit. Ut tincidunt dui tellus, ac imperdiet neque condimentum egestas. Cras libero ex, vulputate eu ipsum non, eleifend dignis", stepAttachmentURL: "", stepTime: 120),
        NewDish.IngredientsAndSteps.Step(stepDescription: "Donec quis vulputate arcu. Fusce augue n", stepAttachmentURL: "", stepTime: 120),
        NewDish.IngredientsAndSteps.Step(stepDescription: "Fusce augue n", stepAttachmentURL: "", stepTime: 120),
        NewDish.IngredientsAndSteps.Step(stepDescription: "Donec quis vulputate arcu.", stepAttachmentURL: "", stepTime: 120),
    ])
    
    private var ingredientsViewController: IngredientsViewController?

    // MARK: - Life cycle
    
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
        
        navigationController?.navigationBar.tintColor = R.color.textBlack()
        
        let firstStepViewController = createFirstStep()
        firstStepViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(firstStepViewController, animated: false)
    }
    
    // MARK: - FirstStep
    
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
                let secondStepViewController = createAddIngredientsStep()
                navigationController?.pushViewController(secondStepViewController, animated: true)
            }
            .store(in: &cancelableSet)
        
        viewModel.didPressBackSubject
            .sink {
                if let mainFlowCoordinator = App.appCoordinator.childCoordinators.first as? MainFlowCoordinator {
                    mainFlowCoordinator.tabBarController.selectedIndex = 0
                }
            }
            .store(in: &cancelableSet)

        return FirstStepViewController(viewModel: viewModel)
    }
    
    // MARK: - AddIngredients
    
    private func createAddIngredientsStep() -> UIViewController {
        
        let viewModel = IngredientsViewModel()
        
        viewModel.didPressPlusPublisher
            .sink { [unowned self] in
                let secondStepViewController = createAddIngredientStep()
                ingredientsViewController?.present(secondStepViewController, animated: true)
            }
            .store(in: &cancelableSet)
        
        viewModel.didPressNextPublisher
            .sink { [unowned self] in
                let secondStepViewController = createAddStepsStep()
                navigationController?.pushViewController(secondStepViewController, animated: true)
            }
            .store(in: &cancelableSet)

        ingredientsViewController = IngredientsViewController(viewModel: viewModel)
        ingredientsViewController?.render(ingredients: ingredientsAndSteps.ingredients)
        return ingredientsViewController!
    }
    
    // MARK: - AddIngredient
    
    private func createAddIngredientStep() -> UIViewController {
        let viewModel = NewIngredientViewModel()
        
        viewModel.didPressDonePublisher
            .sink { [unowned self] in
                ingredientsAndSteps.ingredients.append($0)
                ingredientsViewController?.render(ingredients: ingredientsAndSteps.ingredients)
                ingredientsViewController?.dismiss(animated: true)
            }
            .store(in: &cancelableSet)
        
        viewModel.didPressBackPublisher
            .sink { [unowned self] _ in ingredientsViewController?.dismiss(animated: true) }
            .store(in: &cancelableSet)
        
        let ingredientViewController = NewIngredientViewController(viewModel: viewModel)
        return ingredientViewController
    }
    
    // MARK: - AddSteps
    
    private func createAddStepsStep() -> UIViewController {
        let viewModel = CreateStepsViewModel()
        
        let createStepsViewController = CreateStepsViewController(viewModel: viewModel)
        createStepsViewController.render(steps: ingredientsAndSteps.steps)
        return createStepsViewController
    }
    
    // MARK: - AddStep
    
    // MARK: - ShowAllDish
}

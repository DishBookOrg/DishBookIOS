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
    private var ingredientsAndSteps = IngredientsAndSteps(ingredients: [], steps: [])
    
    private var ingredientsViewController: IngredientsViewController?
    private var createStepsViewController: CreateStepsViewController?

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
            .sink { [unowned self] in newDish.numberOfServings = $0 }
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
        
        viewModel.didPressPlusPublisher
            .sink { [unowned self] in
                ingredientsViewController?.present(createAddNewStepStep(), animated: true)
            }
            .store(in: &cancelableSet)
        
        viewModel.didPressNextPublisher
            .sink(receiveValue: showDishDetail)
            .store(in: &cancelableSet)
        
        createStepsViewController = CreateStepsViewController(viewModel: viewModel)
        createStepsViewController?.render(steps: ingredientsAndSteps.steps)
        return createStepsViewController!
    }
    
    // MARK: - AddStep
    
    private func createAddNewStepStep(_ step: IngredientsAndSteps.Step = IngredientsAndSteps.Step(stepDescription: "", stepAttachmentURL: "", stepTime: 0)) -> UIViewController {
        
        let viewModel = NewStepViewModel(stepNumber: ingredientsAndSteps.steps.count + 1,
                                         step: step)
        
        viewModel.didPressDonePublisher
            .sink { [unowned self] in
                ingredientsAndSteps.steps.append($0)
                newDish.totalTime = (newDish.totalTime ?? 0) + $0.stepTime
                createStepsViewController?.render(steps: ingredientsAndSteps.steps)
                createStepsViewController?.dismiss(animated: true)
            }
            .store(in: &cancelableSet)
        
        viewModel.didPressBackPublisher
            .sink { [unowned self] _ in createStepsViewController?.dismiss(animated: true) }
            .store(in: &cancelableSet)
        
        let ingredientViewController = NewStepViewController(viewModel: viewModel)
        return ingredientViewController
    }
    
    // MARK: - ShowAllDish
    
    private func createDishDetailViewController(with newDish: NewDish) -> DishDetailViewController {
        
        var dish = Dish(newDish: newDish)
        dish.ingredientsAndSteps = ingredientsAndSteps
        dish.imageURL = ingredientsAndSteps.steps.last?.stepAttachmentURL
        
        let viewModel = DishDetailViewModel(dish: dish, type: .newDish)
        
        viewModel.finishLoadNewDishPublisher
            .sink { [unowned self] _ in
                self.newDish = NewDish()
                ingredientsAndSteps = IngredientsAndSteps(ingredients: [], steps: [])
                navigationController?.popToRootViewController(animated: true)
                start()
            }
            .store(in: &cancelableSet)
        
        let viewController = DishDetailViewController(viewModel: viewModel)
        return viewController
    }
    
    private func showDishDetail() {
        
        let controller = createDishDetailViewController(with: newDish)
        navigationController?.pushViewController(controller, animated: true)
    }
}

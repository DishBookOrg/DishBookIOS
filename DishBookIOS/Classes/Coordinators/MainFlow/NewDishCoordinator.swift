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
    private var ingredientsAndSteps = NewDish.IngredientsAndSteps(ingredients: [
        NewDish.IngredientsAndSteps.Ingredient(ingredientName: "Name Name Name", ingredientType: "g", ingredientAmount: 350),
        NewDish.IngredientsAndSteps.Ingredient(ingredientName: "Some", ingredientType: "kg", ingredientAmount: 0.5),
        NewDish.IngredientsAndSteps.Ingredient(ingredientName: "Name Name Name2", ingredientType: "g", ingredientAmount: 350),
        NewDish.IngredientsAndSteps.Ingredient(ingredientName: "Some3", ingredientType: "kg", ingredientAmount: 0.5),
        NewDish.IngredientsAndSteps.Ingredient(ingredientName: "Name Name Name4", ingredientType: "g", ingredientAmount: 350),
        NewDish.IngredientsAndSteps.Ingredient(ingredientName: "Some5", ingredientType: "kg", ingredientAmount: 0.5),
        NewDish.IngredientsAndSteps.Ingredient(ingredientName: "Name Name Name6", ingredientType: "g", ingredientAmount: 350),
        NewDish.IngredientsAndSteps.Ingredient(ingredientName: "Some 7", ingredientType: "kg", ingredientAmount: 0.5),
        NewDish.IngredientsAndSteps.Ingredient(ingredientName: "Name Name Name8", ingredientType: "g", ingredientAmount: 350),
        NewDish.IngredientsAndSteps.Ingredient(ingredientName: "Some9", ingredientType: "kg", ingredientAmount: 0.5),
        NewDish.IngredientsAndSteps.Ingredient(ingredientName: "Name Name Name 10", ingredientType: "g", ingredientAmount: 350),
        NewDish.IngredientsAndSteps.Ingredient(ingredientName: "Some 11", ingredientType: "kg", ingredientAmount: 0.5),
        NewDish.IngredientsAndSteps.Ingredient(ingredientName: "Name Name Name 12", ingredientType: "g", ingredientAmount: 350),
        NewDish.IngredientsAndSteps.Ingredient(ingredientName: "Some 13", ingredientType: "kg", ingredientAmount: 0.5),
        NewDish.IngredientsAndSteps.Ingredient(ingredientName: "Name Name Name 14", ingredientType: "g", ingredientAmount: 350),
        NewDish.IngredientsAndSteps.Ingredient(ingredientName: "Some 15", ingredientType: "kg", ingredientAmount: 0.5),
        NewDish.IngredientsAndSteps.Ingredient(ingredientName: "Name Name Name 16", ingredientType: "g", ingredientAmount: 350),
        NewDish.IngredientsAndSteps.Ingredient(ingredientName: "Some 17", ingredientType: "kg", ingredientAmount: 0.5)
    ], steps: [])

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
                let secondStepViewController = createAddIngredientsStep()
                navigationController?.pushViewController(secondStepViewController, animated: true)
            }
            .store(in: &cancelableSet)

        return FirstStepViewController(viewModel: viewModel)
    }
    
    private func createAddIngredientsStep() -> UIViewController {
        
        let viewModel = IngredientsViewModel()
        
        viewModel.didPressPlusPublisher
            .sink { [unowned self] in
                let secondStepViewController = createAddIngredientStep()
                navigationController?.present(secondStepViewController, animated: true)
            }
            .store(in: &cancelableSet)
        
        viewModel.didPressNextPublisher
            .sink { [unowned self] in
                let secondStepViewController = createAddStepsStep()
                navigationController?.pushViewController(secondStepViewController, animated: true)
            }
            .store(in: &cancelableSet)

        let ingredientsViewController = IngredientsViewController(viewModel: viewModel)
        ingredientsViewController.render(ingredients: ingredientsAndSteps.ingredients)
        return ingredientsViewController
    }
    
    private func createAddIngredientStep() -> UIViewController {
        UIViewController()
    }
    
    private func createAddStepsStep() -> UIViewController {
        UIViewController()
    }
}

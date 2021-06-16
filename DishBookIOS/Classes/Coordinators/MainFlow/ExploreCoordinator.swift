//
//  ExploreCoordinator.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 30.01.2021.
//

import UIKit

final class ExploreCoordinator: BaseRootCoordinator {
    
    override init() {
        super.init()
        
        self.tabItem = UITabBarItem(title: R.string.explore.explore(),
                                    image: R.image.search(),
                                    selectedImage: R.image.search()?.withTintColor(R.color.primaryOrangeMuted()!,
                                                                                   renderingMode: .alwaysOriginal))
        
        navigationController?.isNavigationBarHidden = false
        start()
    }
    
    override func start() {
        
        showExploreList()
    }
    
    // MARK: - Explore list
    
    private func createExploreListViewController() -> ExploreListViewController {
        
        let viewModel = ExploreListViewModel()
        viewModel.didPressDishDetailPublisher
            .sink(receiveValue: showDishDetail)
            .store(in: &cancelableSet)
        
        let exploreController = ExploreListViewController(viewModel: viewModel)
        return exploreController
    }
    
    private func showExploreList() {
        
        let controller = createExploreListViewController()
        navigationController?.pushViewController(controller, animated: false)
    }
    
    // MARK: - Dish detail
    
    private func createDishDetailViewController(with dish: Dish) -> DishDetailViewController {
        
        let viewModel = DishDetailViewModel(dish: dish)
        let viewController = DishDetailViewController(viewModel: viewModel)
        return viewController
    }
    
    private func showDishDetail(with dish: Dish) {
        
        let controller = createDishDetailViewController(with: dish)
        navigationController?.pushViewController(controller, animated: true)
    }
}

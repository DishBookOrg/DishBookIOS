//
//  ExploreListViewController.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 30.01.2021.
//

import UIKit

final class ExploreListViewController: BaseViewController {
    
    // MARK: - Private properties
    
    private var viewModel: ExploreListViewModel
    
    // MARK: - Lifecycle
    
    init?(coder: NSCoder, viewModel: ExploreListViewModel) {
        self.viewModel = viewModel
        
        super.init(coder: coder, closableCoordinator: viewModel)
    }
    
    static func create(viewModel: ExploreListViewModel) -> ExploreListViewController {
        
        return R.storyboard.explore().instantiateViewController(identifier: R.storyboard.explore.exploreViewController.identifier) { coder in
            return ExploreListViewController(coder: coder, viewModel: viewModel)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
}

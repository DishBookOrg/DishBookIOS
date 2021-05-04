//
//  DishBookViewController.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 02.02.2021.
//

import UIKit

final class DishBookViewController: BaseViewController {

    // MARK: - Private properties
    
    private var viewModel: DishBookViewModel
    
    // MARK: - Lifecycle
    
    init?(coder: NSCoder, viewModel: DishBookViewModel) {
        self.viewModel = viewModel
        
        super.init(coder: coder, closableCoordinator: viewModel)
    }
    
    static func create(viewModel: DishBookViewModel) -> DishBookViewController {
        
        return R.storyboard.dishBook().instantiateViewController(identifier: R.storyboard.dishBook.dishBookViewController.identifier) { coder in
            return DishBookViewController(coder: coder, viewModel: viewModel)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        IMPLEMENT_ME()
    }
}

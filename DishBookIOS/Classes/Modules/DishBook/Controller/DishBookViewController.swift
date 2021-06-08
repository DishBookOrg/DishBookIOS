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
    
    init(viewModel: DishBookViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil, closableCoordinator: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        IMPLEMENT_ME()
    }
}

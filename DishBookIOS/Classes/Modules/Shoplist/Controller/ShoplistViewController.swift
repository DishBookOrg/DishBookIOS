//
//  ShoplistViewController.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 02.02.2021.
//

import UIKit

final class ShoplistViewController: BaseViewController {

    // MARK: - Private properties
    
    private var viewModel: ShoplistViewModel
    
    // MARK: - Lifecycle
    
    init(viewModel: ShoplistViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil, closableCoordinator: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

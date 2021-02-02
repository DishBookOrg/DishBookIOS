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
    
    init?(coder: NSCoder, viewModel: ShoplistViewModel) {
        self.viewModel = viewModel
        
        super.init(coder: coder, closableCoordinator: viewModel)
    }
    
    static func create(viewModel: ShoplistViewModel) -> ShoplistViewController {
        
        return R.storyboard.shoplist().instantiateViewController(identifier: R.storyboard.shoplist.shoplistViewController.identifier) { coder in
            return ShoplistViewController(coder: coder, viewModel: viewModel)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

//
//  ExploreViewController.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 30.01.2021.
//

import UIKit
import FirebaseAuth

final class ExploreViewController: BaseViewController {
    
    private var viewModel: ExploreViewModel
    
    init?(coder: NSCoder, viewModel: ExploreViewModel) {
        self.viewModel = viewModel
        
        super.init(coder: coder, closableCoordinator: viewModel)
    }
    
    static func create(viewModel: ExploreViewModel) -> ExploreViewController {
        
        return R.storyboard.explore().instantiateViewController(identifier: R.storyboard.explore.exploreViewController.identifier) { coder in
            return ExploreViewController(coder: coder, viewModel: viewModel)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
    }
    
    @IBAction func logoutAction(_ sender: UIButton) {
        
        App.logout()
    }
}

//
//  NewDishViewController.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 02.02.2021.
//

import UIKit

final class NewDishViewController: BaseViewController {
    
    @IBOutlet weak var customSegmentedControl: CustomSegmentedControl!
    
    // MARK: - Private properties
    
    private var viewModel: NewDishViewModel
    
    // MARK: - Lifecycle
    
    init?(coder: NSCoder, viewModel: NewDishViewModel) {
        self.viewModel = viewModel
        
        super.init(coder: coder, closableCoordinator: viewModel)
    }
    
    static func create(viewModel: NewDishViewModel) -> NewDishViewController {
        
        return R.storyboard.newDish().instantiateViewController(identifier: R.storyboard.newDish.newDishViewController.identifier) { coder in
            return NewDishViewController(coder: coder, viewModel: viewModel)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customSegmentedControl.config(segmentsNames: ["Easy", "Medium", "Hard"], descriptionText: "Some test text?")
        
    }
    
    override func viewDidLayoutSubviews() {
        
    }
}

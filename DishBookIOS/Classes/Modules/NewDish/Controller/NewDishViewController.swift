//
//  NewDishViewController.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 02.02.2021.
//

import UIKit

final class NewDishViewController: BaseViewController {
    
//    @IBOutlet weak var customSegmentedControl: CustomSegmentedControl!
    
    // MARK: - Private properties
    
    private var viewModel: NewDishViewModel
    
    // MARK: - Lifecycle
    
    init(viewModel: NewDishViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil, closableCoordinator: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        customSegmentedControl.config(segmentsNames: ["Easy", "Medium", "Hard"], descriptionText: "Some test text?")
        
    }
    
    override func viewDidLayoutSubviews() {
        
    }
}

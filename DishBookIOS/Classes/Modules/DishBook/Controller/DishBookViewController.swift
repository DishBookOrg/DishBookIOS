//
//  DishBookViewController.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 02.02.2021.
//

import UIKit

final class DishBookViewController: BaseViewController {

    
    private var viewModel: DishBookViewModel
    
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

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

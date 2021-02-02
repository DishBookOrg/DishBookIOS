//
//  BaseViewController.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 30.01.2021.
//

import UIKit
import Combine

class BaseViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var cancelableSet: Set<AnyCancellable> = []
    var showLoader: Bool = false {
        didSet {
            if showLoader {
                Loader.show()
            } else {
                Loader.hide()
            }
        }
    }
    
    var closableCoordinator: ClosableCoordinator
    
    init?(coder: NSCoder, closableCoordinator: ClosableCoordinator) {
        self.closableCoordinator = closableCoordinator
        
        super.init(coder: coder)
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, closableCoordinator: ClosableCoordinator) {
        self.closableCoordinator = closableCoordinator
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Use init?(coder: NSCoder, closableCoordinator: ClosableCoordinator)")
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if showLoader {
            Loader.hide()
        }
    }
    
    @objc
    func close() {
        
        UIApplication.hideKeyboard()
        
        if let presentingViewController = presentingViewController {
            presentingViewController.dismiss(animated: true, completion: nil)
        } else if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}

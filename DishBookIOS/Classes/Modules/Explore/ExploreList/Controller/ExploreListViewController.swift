//
//  ExploreListViewController.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 30.01.2021.
//

import UIKit

final class ExploreListViewController: BaseViewController {
    
    enum Section {
        case main
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
//    let sections: [Section] = [
//        BigItemsSection()
//        SmallItemsSection()
//    ]
    
    // MARK: - Private properties
    
    private var viewModel: ExploreListViewModel
    private var dataSource: UICollectionViewDiffableDataSource<Section, Dish>?
    
    var dishes: [Dish] = [
        Dish(dishName: "Some dish", time: 15),
        Dish(dishName: "Buter", time: 20),
        Dish(dishName: "Soup", time: 20),
        Dish(dishName: "Dish", time: 30),
        Dish(dishName: "Big title diish", time: 40),
        Dish(dishName: "Something", time: 50),
        Dish(dishName: "Soup", time: 60)
    ]
    
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
    
        setupCollectionView()
        
        viewModel.onShowDetails?()
    }
    
    private func setupCollectionView() {
        
        let layout = createLayout()
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(R.nib.dishCardSmallCollectionViewCell)
        
//        let cellRegistration = UICollectionView.CellRegistration<DishCardSmallCollectionViewCell, Dish> { cell, indexPath, item in
//            var configuration = cell.defaultContentConfiguration()
//            cell.configure(with: item)
//            cell.contentConfiguration = configuration
//
//        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Dish>(collectionView: collectionView) {
            collectionView, indexPath, item -> UICollectionViewCell? in
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.dishCardSmallCollectionViewCell, for: indexPath) {
                cell.configure(with: item)
                return cell

            } else {
                return UICollectionViewCell()
            }
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Dish>()

        snapshot.appendSections([.main])
        snapshot.appendItems(dishes, toSection: .main)
        dataSource?.apply(snapshot)
    }
    
    private func configureDataSource() {
        
    }
    
//    private func customLayout() -> UICollectionViewCompositionalLayout {
//
//        let layout = UICollectionViewCompositionalLayout {
//
//        }
//
//    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
        
        
            let smallItemSize = NSCollectionLayoutSize(widthDimension: .absolute(210),
                                                       heightDimension: .absolute(260))
            
            let item = NSCollectionLayoutItem(layoutSize: smallItemSize)
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let groupHeight = NSCollectionLayoutDimension.absolute(260)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(210),
                                                   heightDimension: groupHeight)
            
            let containerGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize, subitems: [item])
            
//
//            let containerGroup = NSCollectionLayoutGroup(layoutSize: groupSize, si)
            
            let section = NSCollectionLayoutSection(group: containerGroup)
            
            section.orthogonalScrollingBehavior = .continuous
            return section
        }
        
//        layout.configuration = .accessInstanceVariablesDirectly
        
        return layout
    }
}

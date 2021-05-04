//
//  ExploreListViewController.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 30.01.2021.
//

import UIKit

final class ExploreListViewController: BaseViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<UICollectionView.Section, Dish>
    typealias Snapshot = NSDiffableDataSourceSnapshot<UICollectionView.Section, Dish>
    
    // MARK: - IBOutlets
    
    lazy var collectionView: UICollectionView = {
        
        let layout = createLayout()
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
//        collectionView.register(R.nib.dishCardSmallCollectionViewCell)
        
        return collectionView
    }()
    
    // MARK: - Private properties
    
    private var viewModel: ExploreListViewModel
    private var dataSource: DataSource!
    
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
    
    init(viewModel: ExploreListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil, closableCoordinator: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .systemBackground
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
                
        view.addSubview(collectionView, withEdgeInsets: .zero)
        
        let collectionViewCell1 = UICollectionView.CellRegistration<DishCardSmallCollectionViewCell, Dish> { (cell, indexPath, model) in
            cell.render(props: model)
        }
        
        
        dataSource = DataSource(collectionView: collectionView) {
            collectionView, indexPath, item -> UICollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: collectionViewCell1, for: indexPath, item: item)
        }
//        
//        dataSource = DataSource(collectionView: collectionView) {
//            collectionView, indexPath, item -> UICollectionViewCell? in
//            
//            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.dishCardSmallCollectionViewCell, for: indexPath) {
//                cell.render(props: data)
//                return cell
//
//            } else {
//                return UICollectionViewCell()
//            }
//        }
//        
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(dishes, toSection: .main)
        dataSource?.apply(snapshot)
    }
    
    private func configureDataSource() {
        
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
        
        
            let smallItemSize = NSCollectionLayoutSize(widthDimension: .absolute(210),
                                                       heightDimension: .absolute(260))
            
            let item = NSCollectionLayoutItem(layoutSize: smallItemSize)
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 25, trailing: 10)
            
            let groupHeight = NSCollectionLayoutDimension.absolute(260)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(210),
                                                   heightDimension: groupHeight)
            
            let containerGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize, subitems: [item])
            
//
//            let containerGroup = NSCollectionLayoutGroup(layoutSize: groupSize, si)
            
            let section = NSCollectionLayoutSection(group: containerGroup)
            
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            return section
        }
        
//        layout.configuration = .accessInstanceVariablesDirectly
        
        return layout
    }
}


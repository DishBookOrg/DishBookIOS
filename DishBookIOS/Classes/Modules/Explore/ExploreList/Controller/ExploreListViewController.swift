//
//  ExploreListViewController.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 30.01.2021.
//

import UIKit

final class ExploreListViewController: BaseViewController {
    
    
    enum Section: Hashable {
        
        case title(text: String)
        case bigSection(id: Int)
        case smallSection(id: Int)
        
        var itemsCount: Int {
            switch self {
            case .title:
                return 1
            case .bigSection:
                return 3
            case .smallSection:
                return 10
            }
        }
        
        var sectionLayout: NSCollectionLayoutSection {
            
            switch self {
            case .smallSection:
                return SmallItemsSection().layoutSection()
            case .bigSection:
                return BigItemsSection().layoutSection()
            case .title:
                return SmallItemsSection().layoutSection()
            }
        }
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<UICollectionView.Section, Dish>
    typealias Snapshot = NSDiffableDataSourceSnapshot<UICollectionView.Section, Dish>
    
    // MARK: - IBOutlets
    
    lazy var collectionView: UICollectionView = {
        
        let layout = createLayout()
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
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
    
    var sections: [Section] = [
        .title(text: "Try it!"),
        .bigSection(id: 0),
        .title(text: "Breakfast"),
        .smallSection(id: 0)
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
        
        let smallDishCollectionViewCell = UICollectionView.CellRegistration<DishCardSmallCollectionViewCell, Dish> { cell, indexPath, model in
            cell.render(props: model)
        }
        
        let bigDishCollectionViewCell = UICollectionView.CellRegistration<DishCardSmallCollectionViewCell, Dish> { cell, indexPath, model in
            cell.render(props: model)
        }
        
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            
            switch indexPath.section {
            case 0:
                return collectionView.dequeueConfiguredReusableCell(using: smallDishCollectionViewCell, for: indexPath, item: item)
            case 1:
                return collectionView.dequeueConfiguredReusableCell(using: bigDishCollectionViewCell, for: indexPath, item: item)
            default:
                return UICollectionViewCell()
            }
        }
        
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(dishes, toSection: .main)
//        snapshot.appendItems([dishes[0], dishes[1]], toSection: .bigSection(id: 0))
//        snapshot.appendItems([dishes[2], dishes[3], dishes[4], dishes[5]], toSection: .smallSection(id: 0))

        dataSource?.apply(snapshot)
    }
    
    private func configureDataSource() {
        
    }
    
//    private func create() -> UICollectionViewCompositionalLayout {
//        
//        
////        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
////
////            return self.sections[sectionIndex].layoutSection()
////        }
////
//        return layout
//    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
        
        
            let smallItemSize = NSCollectionLayoutSize(widthDimension: .absolute(190),
                                                       heightDimension: .absolute(250))
            
            let item = NSCollectionLayoutItem(layoutSize: smallItemSize)
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 25, trailing: 10)
            
            let groupHeight = NSCollectionLayoutDimension.absolute(250)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(190),
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


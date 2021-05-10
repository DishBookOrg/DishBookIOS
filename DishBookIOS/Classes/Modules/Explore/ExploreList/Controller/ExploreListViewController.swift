//
//  ExploreListViewController.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 30.01.2021.
//

import UIKit

final class ExploreListViewController: BaseViewController {
    
    
    enum Section: Hashable {
        
        case bigSection(id: Int, title: String)
        case smallSection(id: Int, title: String)
        
        var itemsCount: Int {
            switch self {
            case .bigSection:
                return 3
            case .smallSection:
                return 10
            }
        }
        
        var title: String {
            switch self {
            case let .bigSection(_, title):
                return title
            case let .smallSection(_, title):
                return title
            }
        }
        
        var sectionLayout: NSCollectionLayoutSection {
            
            switch self {
            case .smallSection:
                return SmallItemsSection().layoutSection()
            case .bigSection:
                return BigItemsSection().layoutSection()
            }
        }
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Dish>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Dish>
    
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
        .bigSection(id: 0, title: "Try it!"),
        .smallSection(id: 0, title: "Breakfast")
    ]
    
    // MARK: - Lifecycle
    
    init(viewModel: ExploreListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil, closableCoordinator: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupDataSource()
        setupCollectionView()
        apply()
    }
    
    private func setupCollectionView() {
        
        view.addSubview(collectionView, withEdgeInsets: .zero)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier)

    }
    
    private func setupDataSource() {
        
        let smallDishCollectionViewCell = UICollectionView.CellRegistration<DishCardSmallCollectionViewCell, Dish> { cell, _, dish in
            cell.render(props: dish)
        }
        
        let bigDishCollectionViewCell = UICollectionView.CellRegistration<DishCardBigCollectionViewCell, Dish> { cell, _, dish in
            cell.render(props: dish)
        }
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            
            switch indexPath.section {
            case 0:
                return collectionView.dequeueConfiguredReusableCell(using: bigDishCollectionViewCell, for: indexPath, item: item)
            case 1:
                return collectionView.dequeueConfiguredReusableCell(using: smallDishCollectionViewCell, for: indexPath, item: item)
            default:
                return UICollectionViewCell()
            }
        }
        
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            
            guard let self = self,
                  let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                      withReuseIdentifier: SectionHeader.reuseIdentifier,
                                                                                      for: indexPath) as? SectionHeader else {
                return nil
            }
            
            sectionHeader.titleLabel.text = self.sections[indexPath.section].title
            return sectionHeader
        }
    }
    
    func apply(animated: Bool = true) {
        
        var snapshot = Snapshot()
        snapshot.appendSections(sections)
        
        snapshot.appendItems([dishes[0], dishes[1]], toSection: sections[0])
        snapshot.appendItems([dishes[2], dishes[3], dishes[4], dishes[5]], toSection: sections[1])
        
        dataSource?.apply(snapshot, animatingDifferences: animated)
    }
    
    private func configureDataSource() {
        
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            
            return self.sections[sectionIndex].sectionLayout
        }
        
        return layout
    }
}

//
//  ExploreListViewController.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 30.01.2021.
//

import UIKit

final class ExploreListViewController: BaseViewController {
    
    // MARK: - Typealiases
    
    typealias DataSource = UICollectionViewDiffableDataSource<ExploreListSection, Dish>
    typealias Snapshot = NSDiffableDataSourceSnapshot<ExploreListSection, Dish>
    
    // MARK: - IBOutlets
    
    private var searchBar: UISearchBar!
    private var blurEffectView: UIVisualEffectView!
    private var collectionView: UICollectionView!
    
    // MARK: - Private properties
    
    private var viewModel: ExploreListViewModel
    private var dataSource: DataSource!
    private var blocks: [ExploreListCollectionBlock] = []
    
    // MARK: - Lifecycle
    
    init(viewModel: ExploreListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil, closableCoordinator: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupDataSource()
        setupSearch()
        setupBinding()
    }
    
    // MARK: - Settup methods
    
    private func setupBinding() {
        
        viewModel.sections
            .sink { [weak self] sections in
                self?.blocks = sections
                self?.apply(animated: true)
            }
            .store(in: &cancelableSet)
        
        viewModel.$showLoader
            .assignNoRetain(to: \.showLoader, on: self)
            .store(in: &cancelableSet)
    }
    
    private func setupSearch() {
        
        blurEffectView = UIVisualEffectView()
        
        view.addSubview(blurEffectView, constraints: [
            blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurEffectView.widthAnchor.constraint(equalTo: view.widthAnchor),
            blurEffectView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        searchBar = UISearchBar()
        searchBar.placeholder = R.string.explore.search()
        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
        searchBar.tintColor = R.color.primaryOrange()
        searchBar.backgroundColor = .clear
        
        blurEffectView.contentView.addSubview(searchBar, constraints: [
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -44),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            blurEffectView.bottomAnchor.constraint(equalTo: searchBar.bottomAnchor)
        ])
    }
    
    private func setupCollectionView() {
        
        let layout = createLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        
        view.addSubview(collectionView, constraints: [
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        collectionView.contentInset = UIEdgeInsets(top: 56, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = collectionView.contentInset
        collectionView.delegate = self
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier)
        collectionView.backgroundColor = .systemBackground
    }
    
    private func setupDataSource() {
        
        let smallDishCollectionViewCell = UICollectionView.CellRegistration<DishCardSmallCollectionViewCell, Dish> { cell, _, dish in
            cell.render(props: dish)
        }
        
        let bigDishCollectionViewCell = UICollectionView.CellRegistration<DishCardBigCollectionViewCell, Dish> { cell, _, dish in
            cell.render(props: dish)
        }
        
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            
            switch self.blocks[indexPath.section].section {
            case .bigSection:
                return collectionView.dequeueConfiguredReusableCell(using: bigDishCollectionViewCell, for: indexPath, item: item)
            case .smallSection:
                return collectionView.dequeueConfiguredReusableCell(using: smallDishCollectionViewCell, for: indexPath, item: item)
            }
        }
        
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            
            guard let self = self,
                  let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                      withReuseIdentifier: SectionHeader.reuseIdentifier,
                                                                                      for: indexPath) as? SectionHeader else {
                return nil
            }
            
            sectionHeader.titleLabel.text = self.blocks[indexPath.section].section.title
            return sectionHeader
        }
    }
    
    // MARK: - Private methods
    
    private func apply(animated: Bool = true) {
        
        guard !blocks.isEmpty else {
            return
        }
        
        var snapshot = Snapshot()
        snapshot.appendSections(blocks.map { $0.section })
        blocks.forEach { snapshot.appendItems($0.items, toSection: $0.section) }
        
        dataSource?.apply(snapshot, animatingDifferences: animated)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            return self.blocks[sectionIndex].section.sectionLayout
        }
        
        return layout
    }
}

// MARK: - ExploreListSection

extension ExploreListViewController {
    
    enum ExploreListSection: Hashable {
        
        case bigSection(id: Int, title: String)
        case smallSection(id: Int, ration: Dish.Ration)
        
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
            case let .smallSection(_, ration):
                return ration.rawValue
            }
        }
        
        var sectionLayout: NSCollectionLayoutSection {
            
            switch self {
            case .smallSection:
                return SmallItemsSection(numberOfItems: itemsCount).layoutSection()
            case .bigSection:
                return BigItemsSection(numberOfItems: itemsCount).layoutSection()
            }
        }
    }
}

// MARK: - UICollectionViewDelegate

extension ExploreListViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        UIView.animate(withDuration: 0.1) { [self] in
            blurEffectView.effect = -scrollView.contentOffset.y > scrollView.contentInset.top + view.safeAreaInsets.top - 1
                ? nil
                : UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let dish = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        print(dish)
        viewModel.didPressDishDetailSubject.send(dish)
    }
}

// MARK: - UISearchBarDelegate

extension ExploreListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.setShowsCancelButton(false, animated: true)
        UIApplication.hideKeyboard()
    }
}

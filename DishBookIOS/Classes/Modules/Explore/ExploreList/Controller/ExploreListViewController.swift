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
    
    // MARK: - State
    
    enum State {
        case explore
        case search
    }
    
    // MARK: - IBOutlets
    
    private var searchBar: UISearchBar!
    private var blurEffectView: UIVisualEffectView!
    private var collectionView: UICollectionView!
    
    // MARK: - Private properties
    
    private var viewModel: ExploreListViewModel
    private var dataSource: DataSource!
    private var blocks: [ExploreListCollectionBlock] = []
    private var state: State = .explore {
        didSet {
            guard state != oldValue else {
                return
            }
            
            switch state {
            case .explore:
                collectionView.setCollectionViewLayout(createLayout(), animated: false)
            case .search:
                collectionView.setCollectionViewLayout(createSearchLayout(), animated: false)
            }
        }
    }
    
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
        
        viewModel.$dishesInSearch
            .dropFirst()
            .sink { [weak self] dishes in
                guard self?.state == .search else {
                    return
                }
                self?.applySearch(dishes)
            }
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
        
        collectionView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
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
        
        dataSource = DataSource(collectionView: collectionView) { [unowned self] collectionView, indexPath, item in
            
            switch self.blocks[indexPath.section].section {
            case .bigSection:
                return collectionView.dequeueConfiguredReusableCell(using: bigDishCollectionViewCell, for: indexPath, item: item)
            case .smallSection:
                return collectionView.dequeueConfiguredReusableCell(using: smallDishCollectionViewCell, for: indexPath, item: item)
            case .search:
                return collectionView.dequeueConfiguredReusableCell(using: bigDishCollectionViewCell, for: indexPath, item: item)
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
    
    private func applySearch(_ dishes: [Dish]) {
        
        var snapshot = Snapshot()
        snapshot.appendSections([.search])
        snapshot.appendItems(dishes, toSection: .search)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            
            return self.blocks[sectionIndex].section.sectionLayout(with: environment)
        }
        
        return layout
    }
    
    private func createSearchLayout() -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout { _, environment in
            
            return ExploreListSection.search.sectionLayout(with: environment)
        }
        
        return layout
    }
}

// MARK: - ExploreListSection

extension ExploreListViewController {
    
    enum ExploreListSection: Hashable {
        
        case bigSection(id: Int, title: String)
        case smallSection(id: Int, ration: Dish.Ration)
        case search
        
        var itemsCount: Int {
            switch self {
            case .bigSection:
                return 3
            case .smallSection:
                return 10
            case .search:
                return 1
            }
        }
        
        var title: String {
            switch self {
            case let .bigSection(_, title):
                return title
            case let .smallSection(_, ration):
                return ration.rawValue
            case .search:
                return ""
            }
        }
        
        func sectionLayout(with environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
            
            switch self {
            case .smallSection:
                return SmallItemsSection(numberOfItems: itemsCount).layoutSection(environment: environment)
            case .bigSection:
                return BigItemsSection(numberOfItems: itemsCount).layoutSection(environment: environment)
            case .search:
                return SearchSection(numberOfItems: itemsCount).layoutSection(environment: environment)
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
        
        viewModel.didPressDishDetailSubject.send(dish)
    }
}

// MARK: - UISearchBarDelegate

extension ExploreListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        state = .search
        
        if !searchText.isEmpty {
            viewModel.searchDishes(with: searchText)
        } else {
            applySearch([])
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.searchTextField.text, text.isEmpty else {
            return
        }
        
        state = .search
        applySearch([])
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.searchTextField.text, text.isEmpty else {
            return
        }
        
        apply(animated: true)
        state = .explore
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        UIApplication.hideKeyboard()
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        
        DispatchQueue.main.async {
            if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
                cancelButton.isEnabled = true
            }
        }
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        state = .explore
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
        apply(animated: true)
        searchBar.searchTextField.text = nil
        searchBar.setShowsCancelButton(false, animated: true)
        UIApplication.hideKeyboard()
    }
}

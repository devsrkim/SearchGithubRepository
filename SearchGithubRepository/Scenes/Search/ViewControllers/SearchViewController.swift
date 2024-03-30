//
//  SearchViewController.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/30.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    private lazy var searchController = UISearchController(
        searchResultsController: SearchResultViewController(viewModel: viewModel.makeSearchResultViewModel())
    ).then {
        $0.searchBar.placeholder = "저장소 검색"
        $0.searchBar.delegate = self
    }

    private let viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension SearchViewController {
    private func setupUI() {
        setupNavigationBar()
        setupRecentSearchView()
    }
    
    private func setupNavigationBar() {
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.searchController = searchController
    }
    
    private func setupRecentSearchView() {
        let recentSearchViewController = RecentSearchViewController(
            viewModel: viewModel.makeRecentSearchViewModel()
        )
        addChild(recentSearchViewController)
        view.addSubview(recentSearchViewController.view)
        recentSearchViewController.didMove(toParent: self)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        viewModel.input.createRecentSearchWord.accept(searchText)
        viewModel.input.getSearchResultByText.accept(searchText)
    }
}

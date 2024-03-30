//
//  SearchResultViewController.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/30.
//

import UIKit

final class SearchResultViewController: BaseViewController {
    
    private let tableView = UITableView().then {
        $0.register(SearchResultItemCell.self, forCellReuseIdentifier: "SearchResultItemCell")
        $0.separatorStyle = .none
        $0.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension SearchResultViewController {
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

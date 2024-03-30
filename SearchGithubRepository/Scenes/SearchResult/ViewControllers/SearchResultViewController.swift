//
//  SearchResultViewController.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/30.
//

import UIKit
import RxDataSources

final class SearchResultViewController: BaseViewController {
    typealias SectionDataSource = RxTableViewSectionedReloadDataSource<SearchResultSectionModel>
    
    private let tableView = UITableView().then {
        $0.register(SearchResultItemCell.self, forCellReuseIdentifier: "SearchResultItemCell")
        $0.rowHeight = 60
        $0.separatorStyle = .none
        $0.backgroundColor = .white
    }
    
    private lazy var dataSource = SectionDataSource(configureCell: { [weak self] _, tableView, indexPath, item -> UITableViewCell in
        guard let self = self,
              let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultItemCell") as? SearchResultItemCell
        else { return UITableViewCell() }
        
        let repository = RepositoryModel(
            title: item.name,
            description: item.owner.description,
            imageURL: item.owner.thumbnailURL
        )
        
        let cellViewModel = SearchResultItemCellViewModel(repository: repository)
        cell.configureViewModel(cellViewModel)
        
        return cell
    })
    
    private let viewModel: SearchResultViewModel
    
    init(viewModel: SearchResultViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
        
        viewModel.input.setupData.accept(())
    }
}

extension SearchResultViewController {
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func bindViewModel() {
        viewModel.output.setSearchResultList
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

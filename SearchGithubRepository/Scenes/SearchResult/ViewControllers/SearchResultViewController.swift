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
    
    private lazy var tableView = UITableView().then {
        $0.register(SearchResultItemCell.self, forCellReuseIdentifier: "SearchResultItemCell")
        $0.delegate = self
        $0.rowHeight = 80
        $0.separatorStyle = .none
        $0.backgroundColor = .white
    }
    
    private let headerView = SearchResultHeaderView()
    
    private lazy var dataSource = SectionDataSource(configureCell: { [weak self] _, tableView, indexPath, item -> UITableViewCell in
        guard let self = self,
              let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultItemCell") as? SearchResultItemCell
        else { return UITableViewCell() }
        
        let repository = RepositoryModel(
            title: item.name,
            description: item.owner.description,
            imageURL: item.owner.thumbnailURL,
            repoURL: item.url
        )
        
        let cellViewModel = self.viewModel.makeSearchResultItemCellViewModel(repository: repository)
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
    }
}

extension SearchResultViewController {
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func bindViewModel() {
        viewModel.output.setSearchResultList
            .withUnretained(self)
            .do(afterNext: { owner, sectionModels in
                if let sectionModel = sectionModels.first, sectionModel.items.count > 0, owner.viewModel.page == 1 {
                    let indexPath = IndexPath(row: 0, section: 0)
                    owner.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                }
            })
            .map { $0.1 }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.output.setTotalCount
            .asDriver(onErrorDriveWith: .empty())
            .drive(with: self, onNext: { owner, totalCountString in
                owner.headerView.configure(countString: totalCountString)
            })
            .disposed(by: disposeBag)
        
        viewModel.output.routeToWebView
            .asDriver(onErrorDriveWith: .empty())
            .drive(with: self, onNext: { owner, url in
                let webViewController = WebViewController(loadURL: url)
                owner.presentingViewController?.navigationController?.pushViewController(webViewController, animated: false)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.willDisplayCell
            .map { $0.indexPath }
            .bind(to: viewModel.input.willDisplay)
            .disposed(by: disposeBag)
        
    }
}

extension SearchResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return SearchResultHeaderView.Constant.height
    }
}

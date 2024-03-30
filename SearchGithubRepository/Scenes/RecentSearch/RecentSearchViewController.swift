//
//  RecentSearchViewController.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/30.
//

import UIKit

final class RecentSearchViewController: BaseViewController {
    
    private lazy var tableView = UITableView().then {
        $0.register(RecentSearchWordCell.self, forCellReuseIdentifier: "RecentSearchWordCell")
        $0.tableFooterView = footerView
        $0.rowHeight = 35
        $0.separatorStyle = .none
        $0.backgroundColor = .white
    }
    
    private let footerView = UIView()
    
    private let deleteAllButton = UIButton().then {
        $0.setTitle("전체삭제", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        $0.setTitleColor(.systemPink, for: .normal)
        $0.isHidden = true
    }
    
    private let bottomLine = UIView().then {
        $0.backgroundColor = .lightGray
        $0.isHidden = true
    }
    
    private let viewModel: RecentSearchViewModel
    
    init(viewModel: RecentSearchViewModel) {
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

extension RecentSearchViewController {
    private func setupUI() {
        let titleLabel = UILabel().then {
            $0.text = "최근 검색"
            $0.textColor = .black
            $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.height.equalTo(40)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        setupFooterView()
    }
    
    private func setupFooterView() {
        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40)
        
        footerView.addSubview(deleteAllButton)
        deleteAllButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(18)
        }
        
        footerView.addSubview(bottomLine)
        bottomLine.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}

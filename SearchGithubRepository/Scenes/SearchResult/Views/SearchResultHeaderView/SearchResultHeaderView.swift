//
//  SearchResultHeaderView.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/30.
//

import UIKit

final class SearchResultHeaderView: UITableViewHeaderFooterView {
    enum Constant {
        static let height: CGFloat = 40
    }
    
    private let countLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = .darkGray
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(countString: String) {
        countLabel.text = countString
    }
}

extension SearchResultHeaderView {
    private func setupUI() {
        self.do {
            $0.backgroundColor = .white
        }

        contentView.addSubview(countLabel)
        countLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(20)
        }
    }
}

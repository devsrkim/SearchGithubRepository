//
//  RecentSearchWordCell.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/30.
//

import UIKit
import SnapKit
import Then

final class RecentSearchWordCell: UITableViewCell {
    private lazy var searchTextLabel = UILabel().then {
        $0.textColor = .darkGray
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    private let deleteButton = UIButton().then {
        $0.setImage(UIImage.init(systemName: "xmark.circle.fill"), for: .normal)
        $0.tintColor = .lightGray
    }
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}

extension RecentSearchWordCell {
    private func setupUI() {
        self.do {
            $0.selectionStyle = .none
        }

        contentView.addSubview(deleteButton)
        deleteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(30)
        }
        
        contentView.addSubview(searchTextLabel)
        searchTextLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(deleteButton.snp.leading).offset(-10)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(25)
        }
    }
}

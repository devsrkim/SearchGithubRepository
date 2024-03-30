//
//  SearchResultItemCell.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/30.
//

import UIKit
import SnapKit
import Then

final class SearchResultItemCell: UITableViewCell {
    private let thumnailImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
    }
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .black
        $0.text = "Swift"
    }
    
    private let descriptionLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .darkGray
        $0.text = "iOS-Swift-Developers"
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

extension SearchResultItemCell {
    private func setupUI() {
        self.do {
            $0.selectionStyle = .none
        }
        
        contentView.addSubview(thumnailImageView)
        thumnailImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(40)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(thumnailImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview()
            $0.top.equalTo(10)
            $0.height.equalTo(30)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.height.equalTo(20)
        }
    }
}


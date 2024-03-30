//
//  RecentSearchEmptyCell.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/30.
//

import UIKit
import SnapKit
import Then


final class RecentSearchEmptyCell: UITableViewCell {
    private let emptyMessageLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textAlignment = .center
        $0.text = "최근 검색어가 없습니다"
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
}

extension RecentSearchEmptyCell {
    private func setupUI() {
        self.do {
            $0.selectionStyle = .none
        }
        
        contentView.addSubview(emptyMessageLabel)
        emptyMessageLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(25)
        }
    }
}

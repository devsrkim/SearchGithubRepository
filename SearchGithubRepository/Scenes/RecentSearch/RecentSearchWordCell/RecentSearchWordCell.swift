//
//  RecentSearchWordCell.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/30.
//

import UIKit
import SnapKit
import Then
import RxSwift

final class RecentSearchWordCell: UITableViewCell {
    private lazy var searchTextLabel = UILabel().then {
        $0.textColor = .darkGray
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    private let deleteButton = UIButton().then {
        $0.setImage(UIImage.init(systemName: "xmark.circle.fill"), for: .normal)
        $0.tintColor = .lightGray
    }
    
    private var viewModel: RecentSearchWordCellViewModel?

    private var disposeBag = DisposeBag()
    
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
        disposeBag = DisposeBag()
    }
    
    func configureViewModel(_ viewModel: RecentSearchWordCellViewModel) {
        self.viewModel = viewModel
        
        bindViewModel()
        
        viewModel.input.setupData.accept(())
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
    
    private func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        viewModel.output.setSearchText
            .bind(to: searchTextLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

//
//  SearchResultItemCell.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/30.
//

import UIKit
import SnapKit
import Then
import RxSwift

final class SearchResultItemCell: UITableViewCell {
    private let thumnailImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .black
    }
    
    private let descriptionLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .darkGray
    }
    
    private var viewModel: SearchResultItemCellViewModel?

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
    
    func configureViewModel(_ viewModel: SearchResultItemCellViewModel) {
        self.viewModel = viewModel
        
        bindViewModel()
        
        viewModel.input.setupData.accept(())
    }
}

extension SearchResultItemCell {
    private func setupUI() {
        self.do {
            $0.selectionStyle = .none
        }
        
        contentView.addSubview(thumnailImageView)
        thumnailImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(40)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(thumnailImageView.snp.trailing).offset(15)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(15)
            $0.height.equalTo(24)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.height.equalTo(20)
        }
    }
    
    private func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        viewModel.output.setTitle
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.setDescription
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.setThumbnailImage
            .bind(to: thumnailImageView.rx.image)
            .disposed(by: disposeBag)
    }
}


//
//  RecentSearchWordCellViewModel.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/30.
//

import Foundation
import RxSwift
import RxCocoa

final class RecentSearchWordCellViewModel: ReactiveViewModel {
    
    struct Input {
        let setupData = PublishRelay<Void>()
        let didTapDeleteButton = PublishRelay<Void>()
        let didTapSearchWord = PublishRelay<Void>()
    }
    
    struct Output {
        let setSearchText = PublishRelay<String>()
        let didTapDeleteButton = PublishRelay<RecentSearch>()
        let didTapSearchWord = PublishRelay<String>()
    }
    
    let input = Input()
    let output = Output()
    
    private let disposeBag = DisposeBag()
    
    private let searchWord: RecentSearch
    
    init(searchWord: RecentSearch) {
        self.searchWord = searchWord
        
        transform()
    }
    
    func transform() {
        input.setupData
            .withUnretained(self)
            .compactMap { $0.0.searchWord.searchText }
            .bind(to: output.setSearchText)
            .disposed(by: disposeBag)
        
        input.didTapDeleteButton
            .withUnretained(self)
            .map { $0.0.searchWord }
            .bind(to: output.didTapDeleteButton)
            .disposed(by: disposeBag)
        
        input.didTapSearchWord
            .withUnretained(self)
            .compactMap { $0.0.searchWord.searchText }
            .bind(to: output.didTapSearchWord)
            .disposed(by: disposeBag)
    }
}

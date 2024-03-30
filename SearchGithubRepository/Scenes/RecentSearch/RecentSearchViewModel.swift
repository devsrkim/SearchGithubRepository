//
//  RecentSearchViewModel.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/30.
//

import Foundation
import RxSwift
import RxCocoa

final class RecentSearchViewModel: ReactiveViewModel {
    
    struct Input {
        let createRecentSearchWord = PublishRelay<String>()
    }
    
    struct Output {
        let setSearchWordList = PublishRelay<Void>()
    }
    
    let input = Input()
    let output = Output()
    
    private let disposeBag = DisposeBag()
    
    private(set) var searchWordList = [RecentSearch]()
    
    init() {
        transform()
    }
    
    func transform() {
        input.createRecentSearchWord
            .withUnretained(self)
            .map { owner, searchText in
                CoreDataManager.shared.create(searchText: searchText)
                owner.searchWordList = CoreDataManager.shared.read()
            }
            .bind(to: output.setSearchWordList)
            .disposed(by: disposeBag)
    }
    
    func makeRecentSearchWordCellViewModel(
        searchWord: RecentSearch
    ) -> RecentSearchWordCellViewModel {
        let viewModel = RecentSearchWordCellViewModel(searchWord: searchWord)
        return viewModel
    }
}

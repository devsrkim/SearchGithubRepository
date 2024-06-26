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
        let setupData = PublishRelay<Void>()
        let createRecentSearchWord = PublishRelay<String>()
        let deleteAllSearchWord = PublishRelay<Void>()
    }
    
    struct Output {
        let setSearchWordList = PublishRelay<Void>()
        let showSearchResult = PublishRelay<String>()
    }
    
    let input = Input()
    let output = Output()
    
    private let disposeBag = DisposeBag()
    
    private(set) var searchWordList = [RecentSearch]()
    
    init() {
        transform()
    }
    
    func transform() {
        input.setupData
            .withUnretained(self)
            .map { owner, _ in
                owner.searchWordList = CoreDataManager.shared.read()
            }
            .bind(to: output.setSearchWordList)
            .disposed(by: disposeBag)

        input.createRecentSearchWord
            .withUnretained(self)
            .map { owner, searchText in
                CoreDataManager.shared.create(searchText: searchText)
                owner.searchWordList = CoreDataManager.shared.read()
            }
            .bind(to: output.setSearchWordList)
            .disposed(by: disposeBag)
        
        input.deleteAllSearchWord
            .withUnretained(self)
            .map { owner, _ in
                CoreDataManager.shared.deleteAll()
                owner.searchWordList = CoreDataManager.shared.read()
            }
            .bind(to: output.setSearchWordList)
            .disposed(by: disposeBag)
    }
    
    func makeRecentSearchWordCellViewModel(
        searchWord: RecentSearch
    ) -> RecentSearchWordCellViewModel {
        let viewModel = RecentSearchWordCellViewModel(searchWord: searchWord)
        
        viewModel.output.didTapDeleteButton
            .withUnretained(self)
            .map { owner, searchWord in
                CoreDataManager.shared.delete(searchWord: searchWord)
                owner.searchWordList = CoreDataManager.shared.read()
            }
            .bind(to: output.setSearchWordList)
            .disposed(by: disposeBag)
        
        viewModel.output.didTapSearchWord
            .bind(to: output.showSearchResult)
            .disposed(by: disposeBag)
        
        return viewModel
    }
}

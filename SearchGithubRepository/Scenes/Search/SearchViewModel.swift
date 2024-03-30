//
//  SearchViewModel.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/30.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel: ReactiveViewModel {
    
    struct Input {
        let createRecentSearchWord = PublishRelay<String>()
    }
    
    struct Output { 
        let createRecentSearchWord = PublishRelay<String>()
    }
    
    let input = Input()
    let output = Output()
    
    private let disposeBag = DisposeBag()
    
    init() {
        transform()
    }
    
    func transform() {
        input.createRecentSearchWord
            .bind(to: output.createRecentSearchWord)
            .disposed(by: disposeBag)
    }
    
    func makeRecentSearchViewModel() -> RecentSearchViewModel {
        let viewModel = RecentSearchViewModel()
        
        output.createRecentSearchWord
            .bind(to: viewModel.input.createRecentSearchWord)
            .disposed(by: disposeBag)

        return viewModel
    }
    
    func makeSearchResultViewModel() -> SearchResultViewModel {
        let viewModel = SearchResultViewModel()
        return viewModel
    }
}

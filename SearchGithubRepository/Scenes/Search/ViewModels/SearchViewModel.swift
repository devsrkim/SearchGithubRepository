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
        let getSearchResultByText = PublishRelay<String>()
    }
    
    struct Output { 
        let createRecentSearchWord = PublishRelay<String>()
        let getSearchResultByText = PublishRelay<String>()
        let showSearchResult = PublishRelay<String>()
    }
    
    let input = Input()
    let output = Output()
    
    private let disposeBag = DisposeBag()
    
    init() {
        transform()
    }
    
    func transform() {
        input.getSearchResultByText
            .bind(to: output.getSearchResultByText)
            .disposed(by: disposeBag)

        input.createRecentSearchWord
            .bind(to: output.createRecentSearchWord)
            .disposed(by: disposeBag)
    }
    
    func makeRecentSearchViewModel() -> RecentSearchViewModel {
        let viewModel = RecentSearchViewModel()
        
        output.createRecentSearchWord
            .bind(to: viewModel.input.createRecentSearchWord)
            .disposed(by: disposeBag)
        
        viewModel.output.showSearchResult
            .bind(to: output.showSearchResult)
            .disposed(by: disposeBag)

        return viewModel
    }
    
    func makeSearchResultViewModel() -> SearchResultViewModel {
        let viewModel = SearchResultViewModel()
        
        output.getSearchResultByText
            .map { ($0, 1) }
            .bind(to: viewModel.input.setupData)
            .disposed(by: disposeBag)
        
        return viewModel
    }
}

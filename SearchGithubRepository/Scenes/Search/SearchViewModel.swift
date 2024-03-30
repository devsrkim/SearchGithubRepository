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
    
    struct Input { }
    
    struct Output { }
    
    let input = Input()
    let output = Output()
    
    private let disposeBag = DisposeBag()
    
    init() {
        transform()
    }
    
    func transform() {
        
    }
    
    func makeRecentSearchViewModel() -> RecentSearchViewModel {
        let viewModel = RecentSearchViewModel()

        return viewModel
    }
}
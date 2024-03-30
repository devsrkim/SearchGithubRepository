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
    }
    
    struct Output {
        let setSearchText = PublishRelay<String>()
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
    }
}

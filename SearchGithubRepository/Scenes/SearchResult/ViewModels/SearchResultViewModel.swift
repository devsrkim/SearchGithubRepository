//
//  SearchResultViewModel.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/30.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchResultViewModel: ReactiveViewModel {
    
    struct Input {
        let setupData = PublishRelay<Void>()
    }
    
    struct Output {
        let setSearchResultList = PublishRelay<[SearchResultSectionModel]>()
    }
    
    let input = Input()
    let output = Output()
    
    private let disposeBag = DisposeBag()
    
    init() {
        transform()
    }
    
    func transform() {
        input.setupData
            .map {
                return []
            }
            .bind(to: output.setSearchResultList)
            .disposed(by: disposeBag)
    }
}

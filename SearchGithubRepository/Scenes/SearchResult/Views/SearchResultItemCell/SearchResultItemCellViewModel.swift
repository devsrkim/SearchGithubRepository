//
//  SearchResultItemCellViewModel.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/30.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchResultItemCellViewModel: ReactiveViewModel {

    struct Input {
        let setupData = PublishRelay<Void>()
    }
    
    struct Output {
        let setTitle = PublishRelay<String>()
        let setDescription = PublishRelay<String>()
    }
    
    let input = Input()
    let output = Output()
    
    private let disposeBag = DisposeBag()
    
    private let repository: RepositoryModel
    
    init(repository: RepositoryModel) {
        self.repository = repository
        
        transform()
    }
    
    func transform() {
        input.setupData
            .withUnretained(self)
            .map { $0.0.repository.title }
            .bind(to: output.setTitle)
            .disposed(by: disposeBag)
        
        input.setupData
            .withUnretained(self)
            .map { $0.0.repository.description }
            .bind(to: output.setDescription)
            .disposed(by: disposeBag)
    }
}


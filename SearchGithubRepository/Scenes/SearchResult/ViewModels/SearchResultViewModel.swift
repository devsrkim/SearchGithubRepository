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
                return [
                    SearchResultSectionModel(
                        identity: .list,
                        items: [
                            RepositorySearchResultResponseModel.Repository(
                                name: "Swift",
                                owner: RepositorySearchResultResponseModel.Repository.Owner(
                                    thumbnailURL: "https://avatars.githubusercontent.com/u/10639145?v=4",
                                    description: "apple"
                                )
                            )
                        ]
                    )
                ]
            }
            .bind(to: output.setSearchResultList)
            .disposed(by: disposeBag)
    }
}

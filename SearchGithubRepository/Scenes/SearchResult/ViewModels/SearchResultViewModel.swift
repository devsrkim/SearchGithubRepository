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
        let setupData = PublishRelay<String>()
    }
    
    struct Output {
        let setSearchResultList = PublishRelay<[SearchResultSectionModel]>()
        let routeToWebView = PublishRelay<String>()
        let errorMessage = PublishRelay<Error?>()
    }
    
    let input = Input()
    let output = Output()
    
    private let disposeBag = DisposeBag()
    
    private let networkManager: NetworkManager<SearchAPI>
    
    init(networkManager: NetworkManager<SearchAPI> = .init()) {
        self.networkManager = networkManager

        transform()
    }
    
    func transform() {
        input.setupData
            .withUnretained(self)
            .flatMap { owner, searchWord -> Single<Result<RepositorySearchResultResponseModel, NetworkError>> in
                return owner.networkManager.request(
                    api: .getSearchResult(searchText: searchWord, page: 1)
                )
            }
            .withUnretained(self)
            .filterMap { owner, response -> FilterMap<[SearchResultSectionModel]> in
                switch response {
                case let .success(result):
                    return .map([
                        SearchResultSectionModel(
                            identity: .list,
                            items: result.items
                        )
                    ])
                case let .failure(error):
                    owner.output.errorMessage.accept(error)
                    return .ignore
                }
            }
            .bind(to: output.setSearchResultList)
            .disposed(by: disposeBag)
    }
    
    func makeSearchResultItemCellViewModel(repository: RepositoryModel) -> SearchResultItemCellViewModel {
        let viewModel = SearchResultItemCellViewModel(repository: repository)
        
        viewModel.output.didTapCell
            .bind(to: output.routeToWebView)
            .disposed(by: disposeBag)
        
        return viewModel
    }
}

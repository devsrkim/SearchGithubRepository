//
//  SearchResultViewModel.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/30.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftExt

final class SearchResultViewModel: ReactiveViewModel {
    
    struct Input {
        let setupData = PublishRelay<(searchWord: String, page: Int)>()
        let willDisplay = PublishRelay<IndexPath>()
    }
    
    struct Output {
        let setSearchResultList = PublishRelay<[SearchResultSectionModel]>()
        let setTotalCount = PublishRelay<String>()
        let routeToWebView = PublishRelay<String>()
        let errorMessage = PublishRelay<Error?>()
    }
    
    let input = Input()
    let output = Output()
    
    private let disposeBag = DisposeBag()
    
    private let networkManager: NetworkManager<SearchAPI>
    
    private var totalCount: Int = 0
    private var searchWord: String = ""
    private var items = [SearchResultSectionModel.Item]()
    
    private(set) var page: Int = 1
    
    init(networkManager: NetworkManager<SearchAPI> = .init()) {
        self.networkManager = networkManager

        transform()
    }
    
    func transform() {
        input.setupData
            .withUnretained(self)
            .flatMap { owner, searchInfo -> Single<Result<RepositorySearchResultResponseModel, NetworkError>> in
                owner.searchWord = searchInfo.searchWord
                owner.page = searchInfo.page

                return owner.networkManager.request(
                    api: .getSearchResult(searchText: searchInfo.searchWord, page: searchInfo.page)
                )
            }
            .withUnretained(self)
            .filterMap { owner, response -> FilterMap<[SearchResultSectionModel]> in
                switch response {
                case let .success(result):
                    owner.output.setTotalCount.accept("\(result.totalCount.toDecimalStyle())개 저장소")
                    owner.totalCount = result.totalCount
                    
                    if owner.page == 1 {
                        owner.items.removeAll()
                    }
                    
                    owner.items.append(contentsOf: result.items)
                    
                    return .map([
                        SearchResultSectionModel(identity: .list, items: owner.items)
                    ])
                case let .failure(error):
                    owner.output.errorMessage.accept(error)
                    return .ignore
                }
            }
            .bind(to: output.setSearchResultList)
            .disposed(by: disposeBag)
        
        input.willDisplay
            .withUnretained(self)
            .filter { owner, indexPath in
                return indexPath.row == owner.items.count - 1 && owner.items.count < owner.totalCount
            }
            .withUnretained(self)
            .map { owner, _ in
                let newPage = owner.page + 1
                return (owner.searchWord, newPage)
            }
            .bind(to: input.setupData)
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

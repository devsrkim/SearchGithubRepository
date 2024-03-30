//
//  SearchResultSectionModel.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/30.
//

import Foundation
import RxDataSources

struct SearchResultSectionModel {
    typealias Repository = RepositorySearchResultResponseModel.Repository
    
    enum Identity: Int {
        case list
    }
    
    let identity: Identity
    var items: [Repository]
    
    init(
        identity: Identity,
        items: [Repository]
    ) {
        self.identity = identity
        self.items = items
    }
}

extension SearchResultSectionModel: SectionModelType {
    init(
        original: SearchResultSectionModel,
        items: [Repository]
    ) {
        self.init(identity: original.identity, items: items)
    }
}

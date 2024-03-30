//
//  SearchAPI.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/30.
//

import Foundation
import Alamofire

enum SearchAPI {
    case getSearchResult(searchText: String, page: Int)
}

extension SearchAPI: APISpec {
    var url: URL {
        switch self {
        case .getSearchResult:
            guard let baseURL = URL(string: "https://api.github.com") else {
                fatalError("API URL is invalid.")
            }
            
            return baseURL
                .appendingPathComponent("search")
                .appendingPathComponent("repositories")
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getSearchResult:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case let .getSearchResult(searchText, page):
            return ["q": searchText, "page": page]
        }
    }
    
    var parameterEncodingType: ParameterEncoding? {
        switch self {
        case .getSearchResult:
            return URLEncoding.default
        }
    }
}

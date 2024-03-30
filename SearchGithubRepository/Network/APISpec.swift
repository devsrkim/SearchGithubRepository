//
//  APISpec.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/30.
//

import Foundation
import Alamofire

protocol APISpec {
    var url: URL { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var header: [String : String]? { get }
    var parameterEncodingType: ParameterEncoding? { get }
    var timeoutInterval: TimeInterval { get }
}

extension APISpec {
    var header: [String : String]? { return nil }
    
    var parameterEncodingType: ParameterEncoding? { return nil }
    
    var timeoutInterval: TimeInterval { 30 }
}

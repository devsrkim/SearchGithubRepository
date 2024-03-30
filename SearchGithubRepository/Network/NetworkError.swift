//
//  NetworkError.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/30.
//

import Foundation

enum NetworkError: Error {
    case parameter(URL, [String: Any]?, Error)
    case jsonDecoding(URLRequest?, URLResponse?, Data, Error?)
    case status(URLRequest?, Int, Data?)
    case other(Error?)
}

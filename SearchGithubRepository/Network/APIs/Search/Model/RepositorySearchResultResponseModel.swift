//
//  RepositorySearchResultResponseModel.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/30.
//

import Foundation

struct RepositorySearchResultResponseModel: Codable {
    let totalCount: Int
    let items: [Repository]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
    
    struct Repository: Codable {
        let name: String
        let owner: Owner
        
        struct Owner: Codable {
            let thumbnailURL: String
            let description: String
            
            enum CodingKeys: String, CodingKey {
                case thumbnailURL = "avatar_url"
                case description = "login"
            }
        }
    }
}

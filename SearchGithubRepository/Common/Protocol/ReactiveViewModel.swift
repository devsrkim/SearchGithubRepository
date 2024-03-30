//
//  ReactiveViewModel.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/30.
//

protocol ReactiveViewModel {
    associatedtype InputType
    associatedtype OutputType
    
    var input: InputType { get }
    var output: OutputType { get }
    
    func transform()
}

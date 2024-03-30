//
//  Int+Extension.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/30.
//

import Foundation

extension Int {
    func toDecimalStyle() -> String {
        return NumberFormatter.localizedString(
            from: NSNumber(value: self),
            number: .decimal
        )
    }
}

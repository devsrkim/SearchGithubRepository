//
//  ImageLoadManager.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/30.
//

import Foundation
import SDWebImage

enum ImageLoadResult {
    case success(UIImage)
    case fail(Error)
}

enum ImageLoadError: Error {
    case loadFailed
}

final class ImageLoadManager {
    static let shared = ImageLoadManager()
    
    func loadImage(url: String, completion: @escaping (ImageLoadResult) -> Void) {
        SDWebImageManager.shared.loadImage(with: URL(string: url), progress: nil) { image, _, error, _, _, _ in
            if let error = error {
                completion(.fail(error))
                return
            }

            guard let image = image else {
                completion(.fail(ImageLoadError.loadFailed))
                return
            }

            completion(.success(image))
        }
    }
}

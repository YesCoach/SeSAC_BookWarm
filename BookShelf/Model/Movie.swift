//
//  Movie.swift
//  BookShelf
//
//  Created by 박태현 on 2023/07/31.
//

import Foundation

struct Movie {
    var title: String
    var releaseDate: String
    var isFavorite: Bool = false
    var runtime: Int
    var overview: String
    var rate: Double
    var posterImageName: String
}

extension Movie {
    var info: String {
        return "\(releaseDate) | \(runtime)분 | \(rate)점"
    }
}

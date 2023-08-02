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
    var platforms: [Platform] = Platform.random
    var memo: String?
}

extension Movie {

    /// "출시년도 | 상영시간 | 평점" 형태로 반환
    var info: String {
        return "\(releaseDate) | \(runtime)분 | \(rate)점"
    }

    /// "출시년도 ∙ 상영시간 ∙ 평점" 형태로 반환
    var homeItemInfo: String {
        return "\(releaseDate) ∙ \(runtime)분 ∙ \(rate)점"
    }
}

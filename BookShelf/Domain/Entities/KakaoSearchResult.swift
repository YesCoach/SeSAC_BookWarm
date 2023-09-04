//
//  KakaoSearchResult.swift
//  BookShelf
//
//  Created by 박태현 on 2023/09/04.
//

import Foundation

struct KakaoSearchResult<T: Codable>: Codable {
    var documents: [T]
    var meta: Meta
}

// MARK: - Meta

struct Meta: Codable {
    var isEnd: Bool
    var pageableCount, totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}

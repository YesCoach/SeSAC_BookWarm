//
//  KakaoSearchResult.swift
//  BookShelf
//
//  Created by 박태현 on 2023/09/04.
//

import Foundation

struct KakaoSearchResult<T> {
    var documents: [T]
    var meta: Meta
}

// MARK: - Meta

struct Meta {
    var isEnd: Bool
    var pageableCount, totalCount: Int
}

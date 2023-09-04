//
//  KakaoSearchResultDTO+Mapping.swift
//  BookShelf
//
//  Created by 박태현 on 2023/09/04.
//

import Foundation

struct KakaoSearchResultDTO<T: DTOMapping>: Codable {
    typealias DomainType = KakaoSearchResult

    var documents: [T]
    var meta: MetaDTO

    func toDomain() -> KakaoSearchResult<T.DomainType> {
        return KakaoSearchResult(
            documents: documents.map { $0.toDomain() },
            meta: meta.toDomain()
        )
    }
}

// MARK: - MetaDTO

struct MetaDTO: DTOMapping {
    typealias DomainType = Meta

    var isEnd: Bool
    var pageableCount, totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }

    func toDomain() -> DomainType {
        return .init(isEnd: isEnd, pageableCount: pageableCount, totalCount: totalCount)
    }
}

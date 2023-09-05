//
//  BookDTO+Mapping.swift
//  BookShelf
//
//  Created by 박태현 on 2023/09/04.
//

import Foundation

struct BookDTO: DTOMapping {
    typealias DomainType = Book

    let authors: [String]?
    let contents, datetime, isbn: String?
    let price: Int?
    let publisher: String?
    let salePrice: Int?
    let status: String?
    let thumbnail: String?
    let title: String?
    let translators: [String]?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case authors, contents, datetime, isbn, price, publisher
        case salePrice = "sale_price"
        case status, thumbnail, title, translators, url
    }
}

extension BookDTO {

    func toDomain() -> DomainType {
        return .init(
            authors: authors,
            contents: contents,
            datetime: datetime,
            isbn: isbn,
            price: price,
            publisher: publisher,
            salePrice: salePrice,
            status: status,
            thumbnail: thumbnail,
            localImageURL: nil,
            title: title,
            translators: translators,
            url: url
        )
    }
}

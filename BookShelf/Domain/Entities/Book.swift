//
//  Book.swift
//  BookShelf
//
//  Created by 박태현 on 2023/08/08.
//

import Foundation

struct Book: Codable {
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

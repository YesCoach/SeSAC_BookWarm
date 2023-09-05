//
//  Book.swift
//  BookShelf
//
//  Created by 박태현 on 2023/08/08.
//

import Foundation

struct Book {
    let isbn: String
    let authors: [String]?
    let contents, datetime: String?
    let price: Int?
    let publisher: String?
    let salePrice: Int?
    let status: String?
    let thumbnail: String?
    let localImageURL: String?
    let title: String?
    let translators: [String]?
    let url: String?
    var isFavorite: Bool = false
    var memo: String?
}

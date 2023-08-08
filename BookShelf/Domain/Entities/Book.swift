//
//  Book.swift
//  BookShelf
//
//  Created by 박태현 on 2023/08/08.
//

import Foundation

struct Book {
    var title: String
    var authors: [String]
    var contents: String
    var price: Int
    var salePrice: Int
    var status: String
    var thumbnail: String
    var translators: [String]

    var isFavorite: Bool = false
}

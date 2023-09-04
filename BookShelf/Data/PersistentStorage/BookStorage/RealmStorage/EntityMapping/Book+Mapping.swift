//
//  Book+Mapping.swift
//  BookShelf
//
//  Created by 박태현 on 2023/09/04.
//

import Foundation
import RealmSwift

class BookEntity: Object {

    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String?
    @Persisted var authors: List<String>
    @Persisted var contents: String?
    @Persisted var datetime: String?
    @Persisted var isbn: String?
    @Persisted var price: Int?
    @Persisted var publisher: String?
    @Persisted var salePrice: Int?
    @Persisted var status: String?
    @Persisted var thumbnail: String?
    @Persisted var translators: List<String>
    @Persisted var url: String?

    convenience init(
        title: String?,
        authors: [String]? = nil,
        contents: String? = nil,
        datetime: String? = nil,
        isbn: String? = nil,
        price: Int? = nil,
        publisher: String? = nil,
        salePrice: Int? = nil,
        status: String? = nil,
        thumbnail: String? = nil,
        translators: [String]? = nil,
        url: String? = nil
    ) {
        self.init()
        self._id = _id
        self.title = title
        self.contents = contents
        self.datetime = datetime
        self.isbn = isbn
        self.price = price
        self.publisher = publisher
        self.salePrice = salePrice
        self.status = status
        self.thumbnail = thumbnail
        self.url = url

        let authorList = List<String>()
        if let authors {
            authorList.append(objectsIn: authors)
        }
        self.authors = authorList

        let translatorList = List<String>()
        if let translators {
            translatorList.append(objectsIn: translators)
        }
        self.translators = translatorList
    }
}

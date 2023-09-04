//
//  Book+Mapping.swift
//  BookShelf
//
//  Created by 박태현 on 2023/09/04.
//

import Foundation
import RealmSwift

class BookEntity: Object, RealmMapping {
    typealias DomainType = Book

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
        self.authorsArray = authors ?? []
        self.translatorsArray = translators ?? []
    }

    func toDomain() -> DomainType {
        return DomainType(
            authors: authorsArray,
            contents: contents,
            datetime: datetime,
            isbn: isbn,
            price: price,
            publisher: publisher,
            salePrice: salePrice,
            status: status,
            thumbnail: thumbnail,
            title: title,
            translators: translatorsArray,
            url: url
        )
    }
}

extension BookEntity {
    var authorsArray: [String] {
        get {
            return authors.map { $0 }
        }
        set {
            authors.removeAll()
            authors.append(objectsIn: newValue)
        }
    }
    var translatorsArray: [String] {
        get {
            return translators.map { $0 }
        }
        set {
            translators.removeAll()
            translators.append(objectsIn: newValue)
        }
    }
}

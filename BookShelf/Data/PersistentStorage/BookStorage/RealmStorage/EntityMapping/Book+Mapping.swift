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

    @Persisted(primaryKey: true) var id: String
    @Persisted var title: String
    @Persisted var authors: List<String>
    @Persisted var contents: String?
    @Persisted var datetime: String?
    @Persisted var price: Int
    @Persisted var publisher: String?
    @Persisted var salePrice: Int?
    @Persisted var status: String?
    @Persisted var thumbnail: String?
    @Persisted var localImageURL: String?
    @Persisted var translators: List<String>
    @Persisted var url: String?
    @Persisted var memo: String?
    @Persisted var isFavorite: Bool
    @Persisted var isAlreadyRead: Bool?

    convenience init(
        id: String,
        title: String,
        authors: [String]?,
        contents: String?,
        datetime: String?,
        price: Int,
        publisher: String?,
        salePrice: Int?,
        status: String?,
        thumbnail: String?,
        translators: [String]?,
        url: String?,
        memo: String?,
        isFavorite: Bool = false,
        isAlreadyRead: Bool? = false
    ) {
        self.init()
        self.id = id
        self.title = title
        self.contents = contents
        self.datetime = datetime
        self.price = price
        self.publisher = publisher
        self.salePrice = salePrice
        self.status = status
        self.thumbnail = thumbnail
        self.url = url
        self.memo = memo
        self.authorsArray = authors ?? []
        self.translatorsArray = translators ?? []
        self.isFavorite = isFavorite
        self.isAlreadyRead = isAlreadyRead

        self.localImageURL = "\(_id).jpg"
    }

    func toDomain() -> DomainType {
        return DomainType(
            isbn: id,
            authors: authorsArray,
            contents: contents,
            datetime: datetime,
            price: price,
            publisher: publisher,
            salePrice: salePrice,
            status: status,
            thumbnail: thumbnail,
            localImageURL: localImageURL,
            title: title,
            translators: translatorsArray,
            url: url,
            isFavorite: isFavorite,
            memo: memo
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

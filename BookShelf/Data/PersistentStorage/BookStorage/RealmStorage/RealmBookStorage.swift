//
//  RealmBookStorage.swift
//  BookShelf
//
//  Created by 박태현 on 2023/09/04.
//

import Foundation

final class RealmBookStorage {

    private let realmStorage: RealmStorage

    init(realmStorage: RealmStorage) {
        self.realmStorage = realmStorage
    }

}

extension RealmBookStorage: BookStorage {

    func storeBookInfo(book: Book) {
        let bookEntity = BookEntity(
            title: book.title,
            authors: book.authors,
            contents: book.contents,
            datetime: book.datetime,
            isbn: book.isbn,
            price: book.price,
            publisher: book.publisher,
            salePrice: book.salePrice,
            status: book.status,
            thumbnail: book.thumbnail,
            translators: book.translators,
            url: book.url
        )
        realmStorage.createData(data: bookEntity)
    }

    func readBookInfo() -> [Book] {
        return realmStorage.readData(BookEntity.self).map { $0.toDomain() }
    }

}

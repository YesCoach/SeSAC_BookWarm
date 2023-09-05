//
//  RealmBookStorage.swift
//  BookShelf
//
//  Created by 박태현 on 2023/09/04.
//

import Foundation
import RealmSwift

final class RealmBookStorage {

    private let realmStorage: RealmStorage

    init(realmStorage: RealmStorage) {
        self.realmStorage = realmStorage
    }

}

extension RealmBookStorage: BookStorage {

    func createBookData(book: Book) {
        let bookEntity = BookEntity(
            id: book.isbn,
            title: book.title!,
            authors: book.authors,
            contents: book.contents,
            datetime: book.datetime,
            price: book.price!,
            publisher: book.publisher,
            salePrice: book.salePrice,
            status: book.status,
            thumbnail: book.thumbnail,
            translators: book.translators,
            url: book.url,
            memo: book.memo
        )
        realmStorage.createData(data: bookEntity)
    }

    func readBookData() -> [Book] {
        return realmStorage.readData(BookEntity.self).map { $0.toDomain() }
    }

    func updateBookData(book: Book) {
        do {
            let realm = try Realm()
            if let object = realm.object(
                ofType: BookEntity.self,
                forPrimaryKey: book.isbn
            ) {
                realmStorage.updateData(data: object) { object in
                    object.memo = book.memo
                    object.isFavorite = book.isFavorite
                }
            }
        } catch {
            print(error)
        }
    }
}

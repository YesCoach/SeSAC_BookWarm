//
//  DefaultLocalBookRepository.swift
//  BookShelf
//
//  Created by 박태현 on 2023/09/05.
//

import Foundation

final class DefaultLocalBookRepository {

    private let bookStorage: BookStorage

    init(bookStorage: BookStorage) {
        self.bookStorage = bookStorage
    }

}

extension DefaultLocalBookRepository: LocalBookRepository {

    func createBookData(book: Book) {
        bookStorage.createBookData(book: book)
    }

    func readBookData() -> [Book] {
        return bookStorage.readBookData().map { $0 }
    }

    func updateBookData(book: Book) {
        return bookStorage.updateBookData(book: book)
    }

    func deleteBookData(book: Book) {
        bookStorage.deleteBookData(book: book)
    }
}

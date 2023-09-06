//
//  LocalBookUseCase.swift
//  BookShelf
//
//  Created by 박태현 on 2023/09/04.
//

import Foundation

protocol LocalBookUseCase {
    func readBookData() -> [Book]
    func createBookData(book: Book)
    func updateBookData(book: Book)
    func deleteBookData(book: Book)
}

final class DefaultLocalBookUseCase {

    private let localBookRepository: LocalBookRepository

    init(localBookRepository: LocalBookRepository) {
        self.localBookRepository = localBookRepository
    }
}

extension DefaultLocalBookUseCase: LocalBookUseCase {

    func readBookData() -> [Book] {
        return localBookRepository.readBookData()
    }

    func createBookData(book: Book) {
        localBookRepository.createBookData(book: book)
    }

    func updateBookData(book: Book) {
        localBookRepository.updateBookData(book: book)
    }

    func deleteBookData(book: Book) {
        localBookRepository.deleteBookData(book: book)
    }

}

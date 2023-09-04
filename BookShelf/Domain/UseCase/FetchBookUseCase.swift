//
//  FetchBookUseCase.swift
//  BookShelf
//
//  Created by 박태현 on 2023/09/04.
//

import Foundation

protocol FetchBookUseCase {
    func fetchSavedBookData() -> [Book]
}

final class DefaultFetchBookUseCase {

    private let bookRepository: BookRepository

    init(bookRepository: BookRepository) {
        self.bookRepository = bookRepository
    }
}

extension DefaultFetchBookUseCase: FetchBookUseCase {

    func fetchSavedBookData() -> [Book] {
        return bookRepository.readBookInfo()
    }
}

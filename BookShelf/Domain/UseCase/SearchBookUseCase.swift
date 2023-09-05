//
//  SearchBookUseCase.swift
//  BookShelf
//
//  Created by 박태현 on 2023/09/04.
//

import Foundation

protocol SearchBookUseCase {
    func searchBook(
        query: String,
        page: Int,
        completion: @escaping (Result<KakaoSearchResult<Book>, APIError>) -> ()
    )
}

final class DefaultSearchBookUseCase: SearchBookUseCase {

    private let bookRepository: BookRepository

    init(bookRepository: BookRepository) {
        self.bookRepository = bookRepository
    }

    func searchBook(
        query: String,
        page: Int,
        completion: @escaping (Result<KakaoSearchResult<Book>, APIError>) -> ()
    ) {
        bookRepository.fetchBookList(query: query, page: page) { result in
            completion(result)
        }
    }
}

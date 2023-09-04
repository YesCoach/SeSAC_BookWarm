//
//  DefaultBookRepository.swift
//  BookShelf
//
//  Created by 박태현 on 2023/09/04.
//

import Foundation

final class DefaultBookRepository {

    private let networkManager: NetworkManager
    private let bookStorage: BookStorage

    init(networkManager: NetworkManager, bookStorage: BookStorage) {
        self.networkManager = networkManager
        self.bookStorage = bookStorage
    }

}

extension DefaultBookRepository: BookRepository {
    func fetchBookList(
        query: String,
        page: Int,
        completion: @escaping (Result<KakaoSearchResult<Book>, APIError>) -> ()
    ) {
        networkManager.request(
            api: .search(type: .book, query: query, page: page)
        ) { (result: Result<KakaoSearchResultDTO<BookDTO>, APIError>) in
            switch result {
            case .success(let data):
                completion(.success(data.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func storeBookInfo(book: Book) {
        bookStorage.storeBookInfo(book: book)
    }

    func readBookInfo() -> [Book] {
        return bookStorage.readBookInfo()
    }
}

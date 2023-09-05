//
//  DefaultBookRepository.swift
//  BookShelf
//
//  Created by 박태현 on 2023/09/04.
//

import Foundation

final class DefaultBookRepository {

    private let networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
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
}

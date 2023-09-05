//
//  BookRepository.swift
//  BookShelf
//
//  Created by 박태현 on 2023/09/04.
//

import Foundation

protocol BookRepository {
    func fetchBookList(query: String, page: Int, completion: @escaping (Result<KakaoSearchResult<Book>, APIError>) -> ())
}

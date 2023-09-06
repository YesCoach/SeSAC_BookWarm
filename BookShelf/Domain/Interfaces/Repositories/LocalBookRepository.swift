//
//  LocalBookRepository.swift
//  BookShelf
//
//  Created by 박태현 on 2023/09/05.
//

import Foundation

protocol LocalBookRepository {
    func createBookData(book: Book)
    func readBookData() -> [Book]
    func updateBookData(book: Book)
    func deleteBookData(book: Book)
}

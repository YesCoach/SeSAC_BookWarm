//
//  BookStorage.swift
//  BookShelf
//
//  Created by 박태현 on 2023/09/04.
//

import Foundation

protocol BookStorage {
    func createBookData(book: Book)
    func readBookData() -> [Book]
    func updateBookData(book: Book)
}

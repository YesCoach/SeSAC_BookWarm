//
//  APIError.swift
//  BookShelf
//
//  Created by 박태현 on 2023/09/04.
//

import Foundation

enum APIError: Error {
    case failedRequest
    case noData
    case invalidResponse
    case invalidData
    case invalidURL
}

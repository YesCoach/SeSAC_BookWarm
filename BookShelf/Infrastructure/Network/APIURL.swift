//
//  APIURL.swift
//  BookShelf
//
//  Created by 박태현 on 2023/09/04.
//

import Foundation

enum APIURL {

    enum Kakao {
        case search(type: SearchType, query: String, page: Int)
    }

}

extension APIURL.Kakao {

    enum SearchType: String {
        case book
    }

    static let baseURL = "https://dapi.kakao.com/v3/"

    private var urlComponents: URLComponents? {
        switch self {
        case let .search(type, _, _):
            return URLComponents(
                string: Self.baseURL + "search/\(type.rawValue)?"
            )
        }
    }

    var url: URL? {
        var urlComponents = self.urlComponents
        var urlQueryItems: [URLQueryItem] = []

        switch self {
        case let .search( _, query, page):
            let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            urlQueryItems = [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        }
        urlQueryItems.forEach {
            urlComponents?.queryItems?.append($0)
        }
        return urlComponents?.url
    }

}

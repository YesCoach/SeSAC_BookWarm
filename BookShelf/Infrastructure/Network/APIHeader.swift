//
//  APIHeader.swift
//  BookShelf
//
//  Created by 박태현 on 2023/09/04.
//

import Foundation

enum APIHeader {

    enum Kakao {
        static let header: [String: String] = [
            "Authorization": "KakaoAK \(APIKey.kakaoKey)"
        ]
    }

}

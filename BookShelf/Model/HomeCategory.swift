//
//  HomeCategory.swift
//  BookShelf
//
//  Created by 박태현 on 2023/08/02.
//

import Foundation

enum HomeCategory {
    case recently
    case popluar
}

extension HomeCategory {
    var description: String {
        switch self {
        case .recently: return "최근 본 작품"
        case .popluar: return "요즘 인기 작품"
        }
    }
}

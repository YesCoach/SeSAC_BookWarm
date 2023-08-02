//
//  OTT.swift
//  BookShelf
//
//  Created by 박태현 on 2023/08/02.
//

import Foundation

enum Platform: CaseIterable {
    case netflix
    case watcha
    case tving
}

extension Platform {
    var imageName: String {
        switch self {
        case .netflix: return "netflix_logo"
        case .watcha: return "watcha_logo"
        case .tving: return "tving_logo"
        }
    }

    /// OTT Platform을 랜덤으로 뽑아서 담은 배열입니다.
    static var random: [Platform] {
        var allCases = Self.allCases
        var result: [Platform] = []

        let count = (0...allCases.count).randomElement() ?? 0

        for _ in 0..<count {
            if let element = allCases.randomElement() {
                allCases.removeAll { $0 == element }
                result.append(element)
            }
        }

        return result
    }
}

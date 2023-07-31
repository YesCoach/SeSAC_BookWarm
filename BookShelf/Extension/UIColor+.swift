//
//  UIColor+.swift
//  BookShelf
//
//  Created by 박태현 on 2023/07/31.
//

import UIKit

extension UIColor {

    /// 랜덤으로 UIColor 색상을 반환합니다.
    static var random: UIColor {
        let color: [UIColor] = [
            .systemGreen, .systemRed, .systemMint, .systemOrange, .systemYellow,
            .systemPurple, .systemCyan, .systemBlue
        ]
        return color.randomElement() ?? .black
    }
}

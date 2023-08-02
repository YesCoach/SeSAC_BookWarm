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
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)

        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}

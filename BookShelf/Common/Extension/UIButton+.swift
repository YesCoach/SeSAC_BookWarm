//
//  UIButton+.swift
//  BookShelf
//
//  Created by 박태현 on 2023/08/02.
//

import UIKit

extension UIButton {

    /// platform 로고를 담은 버튼을 생성합니다.
    /// - Parameter platform: 영화의  플랫폼 정보를 담은 열거형 타입입니다.
    /// - Returns: 로고를 이미지로 하는 버튼을 반환합니다.
    static func makePlatformButton(_ platform: Platform) -> UIButton {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 5.0
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.masksToBounds = true
        button.setImage(.init(named: platform.imageName), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill

        button.widthAnchor.constraint(equalToConstant: 42).isActive = true
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

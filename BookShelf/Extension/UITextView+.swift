//
//  UITextView+.swift
//  BookShelf
//
//  Created by 박태현 on 2023/08/01.
//

import UIKit

extension UITextView {

    /// 텍스트뷰에 placeholder를 적용합니다.
    /// - Parameter text: 적용할 placeholder 문자열
    func setupPlaceHolder(with text: String) {
        let spacing = 4.0
        self.textContainerInset = UIEdgeInsets(
            top: spacing,
            left: spacing,
            bottom: spacing,
            right: spacing
        )
        self.font = .systemFont(ofSize: 18)
        self.text = text
        self.textColor = .secondaryLabel
    }
}

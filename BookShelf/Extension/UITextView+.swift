//
//  UITextView+.swift
//  BookShelf
//
//  Created by 박태현 on 2023/08/01.
//

import UIKit

extension UITextView {

    /// 텍스트뷰에 placeholder를 적용합니다.
    /// 텍스트뷰에 text가 이미 있다면, placeholder는 적용하지 않습니다.
    /// - Parameter text: 적용할 placeholder 문자열
    func setupPlaceHolder(with text: String) {
        let spacing = 4.0
        self.textContainerInset = UIEdgeInsets(
            top: spacing,
            left: spacing,
            bottom: spacing,
            right: spacing
        )
        self.font = .systemFont(ofSize: 13)
        self.textColor = .label

        if self.text!.isEmpty {
            self.text = text
            self.textColor = .secondaryLabel
        }
    }
}

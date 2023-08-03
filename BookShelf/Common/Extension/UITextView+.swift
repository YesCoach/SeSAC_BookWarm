//
//  UITextView+.swift
//  BookShelf
//
//  Created by 박태현 on 2023/08/01.
//

import UIKit

extension UITextView {

    /// 텍스트뷰에 placeholder를 적용합니다.
    /// 만약 텍스트뷰의 text가 비어있지 않다면, 적용하지 않습니다.
    /// - Parameter text: 적용할 placeholder 문자열
    func setupPlaceHolder(with text: String) {
        if self.text!.isEmpty {
            self.text = text
            self.textColor = .secondaryLabel
        }
    }

    /// DetailViewController의 TextView UI를 적용합니다.
    func setupDetailTextView() {
        let spacing = 4.0
        self.textContainerInset = UIEdgeInsets(
            top: spacing,
            left: spacing,
            bottom: spacing,
            right: spacing
        )
        self.font = .systemFont(ofSize: 13)
        self.textColor = .label
    }
}

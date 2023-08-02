//
//  UIStackView+.swift
//  BookShelf
//
//  Created by 박태현 on 2023/08/02.
//

import UIKit

extension UIStackView {

    /// 스택뷰의 모든 서브뷰들을 스택뷰에서 제거합니다.
    func removeAllSubviews() {
        self.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
}

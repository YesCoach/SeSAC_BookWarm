//
//  ReusableView.swift
//  BookShelf
//
//  Created by 박태현 on 2023/09/04.
//

import UIKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

extension UIViewController: ReusableView { }
extension UITableViewCell: ReusableView { }
extension UICollectionViewCell: ReusableView { }

extension ReusableView {

    static var identifier: String {
        return String(describing: self)
    }

}

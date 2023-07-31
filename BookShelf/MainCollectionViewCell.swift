//
//  MainCollectionViewCell.swift
//  BookShelf
//
//  Created by 박태현 on 2023/07/31.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    static let identifier = "MainCollectionViewCell"

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
}

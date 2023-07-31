//
//  MainCollectionViewCell.swift
//  BookShelf
//
//  Created by 박태현 on 2023/07/31.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    static let identifier = "MainCollectionViewCell"

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
}

extension MainCollectionViewCell {
    func configure(with data: Movie) {
        configureUI()
        nameLabel.text = data.title
        rateLabel.text = "\(data.rate)점"
        posterImageView.image = UIImage(named: data.posterImageName)
        posterImageView.contentMode = .scaleAspectFill
    }
}

private extension MainCollectionViewCell {
    func configureUI() {
        contentView.backgroundColor = .random
        contentView.layer.cornerRadius = 15.0
    }
}

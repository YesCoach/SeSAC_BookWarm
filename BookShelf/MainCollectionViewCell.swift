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
        rateLabel.text = "\(data.rate)"
        posterImageView.image = UIImage(named: data.posterImageName)
        posterImageView.contentMode = .scaleAspectFill
    }
}

private extension MainCollectionViewCell {
    func configureUI() {
        contentView.backgroundColor = .random
        contentView.layer.cornerRadius = 15.0
        nameLabel.font = .boldSystemFont(ofSize: 20.0)
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 1
        rateLabel.textColor = .white
        rateLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
    }
}

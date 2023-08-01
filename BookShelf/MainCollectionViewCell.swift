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
    @IBOutlet var favoriteButton: UIButton!

    var completionHandler: ((Bool) -> ())?

    @IBAction func didFavoriteButtonTouched(_ sender: UIButton) {
        sender.isSelected.toggle()
        completionHandler?(sender.isSelected)
    }
}

extension MainCollectionViewCell {
    func configure(with data: Movie, completion: @escaping (Bool) -> ()) {
        configureUI()
        nameLabel.text = data.title
        rateLabel.text = "\(data.rate)"
        posterImageView.image = UIImage(named: data.posterImageName)
        posterImageView.contentMode = .scaleAspectFill
        favoriteButton.isSelected = data.isFavorite

        completionHandler = completion
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
        favoriteButton.setImage(.init(systemName: "star"), for: .normal)
        favoriteButton.setImage(.init(systemName: "star.fill"), for: .selected)
    }
}

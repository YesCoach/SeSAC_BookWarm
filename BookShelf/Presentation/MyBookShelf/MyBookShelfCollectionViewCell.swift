//
//  MyBookShelfCollectionViewCell.swift
//  BookShelf
//
//  Created by 박태현 on 2023/07/31.
//

import UIKit

class MyBookShelfCollectionViewCell: UICollectionViewCell {

    static let identifier = "MyBookShelfCollectionViewCell"

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var favoriteButton: UIButton!

    var completionHandler: ((Bool) -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    @IBAction func didFavoriteButtonTouched(_ sender: UIButton) {
        sender.isSelected.toggle()
        completionHandler?(sender.isSelected)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        favoriteButton.isSelected = false
        completionHandler = nil
    }
}

extension MyBookShelfCollectionViewCell {
    func configure(with data: Movie, completion: @escaping (Bool) -> ()) {
        nameLabel.text = data.title
        rateLabel.text = "\(data.rate)"
        posterImageView.image = UIImage(named: data.posterImageName)
        posterImageView.contentMode = .scaleAspectFill
        favoriteButton.isSelected = data.isFavorite

        completionHandler = completion
    }
}

private extension MyBookShelfCollectionViewCell {
    func configureUI() {
        contentView.backgroundColor = .random
        contentView.layer.cornerRadius = 15.0
        nameLabel.font = .boldSystemFont(ofSize: 20.0)
        nameLabel.textColor = .white
        nameLabel.minimumScaleFactor = 0.6
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.numberOfLines = 1
        rateLabel.textColor = .white
        rateLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        favoriteButton.setImage(.init(systemName: "star"), for: .normal)
        favoriteButton.setImage(.init(systemName: "star.fill"), for: .selected)
    }
}

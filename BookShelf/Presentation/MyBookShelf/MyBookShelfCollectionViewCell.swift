//
//  MyBookShelfCollectionViewCell.swift
//  BookShelf
//
//  Created by 박태현 on 2023/07/31.
//

import UIKit

class MyBookShelfCollectionViewCell: UICollectionViewCell {

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
        favoriteButton.isSelected = data.isFavorite

        completionHandler = completion
    }

    func configure(with data: Book) {
        nameLabel.text = data.title
        rateLabel.text = ""
        if let _url = data.thumbnail,
           let url = URL(string: _url),
           let localImageURL = data.localImageURL
        {
            if let localImage = FileSystemManager
                .shared
                .loadImageFromDocument(fileName: localImageURL)
            {
                posterImageView.image = localImage
                print("localImage loaded")
            } else {
                posterImageView.kf.setImage(with: url) { result in
                    switch result {
                    case .success(let kfResult):
                        FileSystemManager.shared.saveImageToDocument(
                            fileName: localImageURL,
                            image: kfResult.image
                        )
                    case .failure(let error):
                        debugPrint(error)
                        if let image = UIImage(systemName: "photo") {
                            FileSystemManager.shared.saveImageToDocument(
                                fileName: localImageURL,
                                image: image
                            )
                        }
                    }
                }
            }
        }
        favoriteButton.isSelected = data.isFavorite
    }
}

private extension MyBookShelfCollectionViewCell {
    func configureUI() {
        contentView.backgroundColor = .random
        contentView.layer.cornerRadius = 15.0
        posterImageView.contentMode = .scaleAspectFill
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

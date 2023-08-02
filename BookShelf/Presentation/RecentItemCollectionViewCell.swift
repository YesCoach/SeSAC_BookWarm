//
//  RecentItemCollectionViewCell.swift
//  BookShelf
//
//  Created by 박태현 on 2023/08/02.
//

import UIKit

final class RecentItemCollectionViewCell: UICollectionViewCell {

    static let identifier = "RecentItemCollectionViewCell"

    @IBOutlet var posterImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
}

private extension RecentItemCollectionViewCell {
    func configureUI() {
        posterImageView.contentMode = .scaleAspectFill

        posterImageView.layer.cornerRadius = 5.0
        self.layer.cornerRadius = 5.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.5
        self.clipsToBounds = false
    }
}

extension RecentItemCollectionViewCell {
    func configure(with data: Movie) {
        posterImageView.image = .init(named: data.posterImageName)
    }
}

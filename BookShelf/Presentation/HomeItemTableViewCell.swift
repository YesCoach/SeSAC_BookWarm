//
//  HomeItemTableViewCell.swift
//  BookShelf
//
//  Created by 박태현 on 2023/08/02.
//

import UIKit

final class HomeItemTableViewCell: UITableViewCell {

    static let identifier = "HomeItemTableViewCell"

    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var stackView: UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
}

private extension HomeItemTableViewCell {
    func configureUI() {
        posterImageView.layer.cornerRadius = 10.0
        posterImageView.contentMode = .scaleAspectFill
        titleLabel.font = .systemFont(ofSize: 15.0, weight: .regular)
        titleLabel.numberOfLines = 1
        infoLabel.font = .systemFont(ofSize: 13.0, weight: .regular)
        infoLabel.textColor = .secondaryLabel
    }
}

extension HomeItemTableViewCell {
    func configure(with data: Movie) {
        posterImageView.image = UIImage(named: data.posterImageName)
        titleLabel.text = data.title
        infoLabel.text = data.homeItemInfo
    }
}

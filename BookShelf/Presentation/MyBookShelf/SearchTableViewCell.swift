//
//  SearchTableViewCell.swift
//  BookShelf
//
//  Created by 박태현 on 2023/08/08.
//

import UIKit
import Kingfisher

final class SearchTableViewCell: UITableViewCell {

    static let identifier = "SearchTableViewCell"

    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var translatorLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func prepareForReuse() {
        thumbnailImageView.image = nil
    }
}

extension SearchTableViewCell {

    func configure(with book: Book) {
        let url = URL(string: book.thumbnail)
        thumbnailImageView.kf.setImage(with: url)
        nameLabel.text = book.title
        authorLabel.text = book.authors.joined(separator: ", ")
        translatorLabel.text = book.translators.joined(separator: ", ")
        priceLabel.text = "\(book.price)원"
        statusLabel.text = book.status
        contentLabel.text = book.contents
    }

}

private extension SearchTableViewCell {

    func configureUI() {
        nameLabel.font = .systemFont(ofSize: 15.0, weight: .semibold)
        authorLabel.font = .systemFont(ofSize: 13.0, weight: .regular)
        translatorLabel.font = .systemFont(ofSize: 13.0, weight: .regular)
        priceLabel.font = .systemFont(ofSize: 14.0, weight: .semibold)
        contentLabel.font = .systemFont(ofSize: 13.0, weight: .regular)

        authorLabel.textColor = .lightGray
        translatorLabel.textColor = .lightGray

        statusLabel.font = .systemFont(ofSize: 14.0, weight: .semibold)
        contentLabel.numberOfLines = 0

        thumbnailImageView.contentMode = .scaleAspectFit
    }

}

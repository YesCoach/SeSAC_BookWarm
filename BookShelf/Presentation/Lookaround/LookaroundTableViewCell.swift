//
//  LookaroundTableViewCell.swift
//  BookShelf
//
//  Created by 박태현 on 2023/08/02.
//

import UIKit

final class LookaroundTableViewCell: UITableViewCell {

    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var platformStackView: UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        platformStackView.removeAllSubviews()
    }

    
}

private extension LookaroundTableViewCell {
    func configureUI() {
        posterImageView.layer.cornerRadius = 10.0
        posterImageView.contentMode = .scaleAspectFill
        titleLabel.font = .systemFont(ofSize: 15.0, weight: .semibold)
        titleLabel.numberOfLines = 1
        infoLabel.font = .systemFont(ofSize: 13.0, weight: .regular)
        infoLabel.textColor = .secondaryLabel

        stackView.spacing = 8.0
    }
}

extension LookaroundTableViewCell {
    func configure(with data: Movie) {
        posterImageView.image = UIImage(named: data.posterImageName)
        titleLabel.text = data.title
        infoLabel.text = data.homeItemInfo

        if data.platforms.isEmpty == false {
            for platform in data.platforms {
                let button = UIButton.makePlatformButton(platform)
                platformStackView.addArrangedSubview(button)
            }
            platformStackView.addArrangedSubview(UIView())

            // TODO: - 버튼 관련 이슈 해결 안됨
            layoutIfNeeded()
        }
    }
}

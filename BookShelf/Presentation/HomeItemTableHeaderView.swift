//
//  HomeItemTableHeaderView.swift
//  BookShelf
//
//  Created by 박태현 on 2023/08/02.
//

import UIKit

final class HomeItemTableHeaderView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HomeItemTableHeaderView {
    func configureUI() {
        addSubview(titleLabel)
        [
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ].forEach {
            $0.isActive = true
        }
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension HomeItemTableHeaderView {
    func configure(with category: HomeCategory) {
        titleLabel.text = category.description
    }
}

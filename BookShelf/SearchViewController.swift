//
//  SearchViewController.swift
//  BookShelf
//
//  Created by 박태현 on 2023/07/31.
//

import UIKit

final class SearchViewController: UIViewController {

    static let identifier = "SearchViewController"

    @IBOutlet var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationItem()
        configure(with: "검색 화면")
    }

    @objc func didDismissButtonTouched(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

private extension SearchViewController {
    func configureUI() {
        resultLabel.font = .systemFont(ofSize: 24.0)
    }

    func configureNavigationItem() {
        navigationItem.title = "검색 화면"
        let dismissButton = UIBarButtonItem(
            image: .init(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(didDismissButtonTouched)
        )
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.leftBarButtonItem?.tintColor = .systemMint
    }
}

extension SearchViewController {
    func configure(with keyword: String) {
        resultLabel.text = keyword
    }
}

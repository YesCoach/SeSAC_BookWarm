//
//  SearchViewController.swift
//  BookShelf
//
//  Created by 박태현 on 2023/07/31.
//

import UIKit

final class SearchViewController: UIViewController {

    static let identifier = "SearchViewController"

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "제목을 입력하세요."
        searchBar.delegate = self
        return searchBar
    }()

    @IBOutlet var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationItem()
        configure(with: "검색 화면")
    }

    @IBAction func didBackgroundViewTouched(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
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
        let dismissButton = UIBarButtonItem(
            image: .init(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(didDismissButtonTouched)
        )
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.leftBarButtonItem?.tintColor = .systemMint

        navigationItem.titleView = searchBar
    }
}

extension SearchViewController {
    func configure(with keyword: String) {
        resultLabel.text = keyword
    }
}

// MARK: - SearchBarDelegate

extension SearchViewController: UISearchBarDelegate {

}

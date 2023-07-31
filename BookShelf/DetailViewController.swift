//
//  DetailViewController.swift
//  BookShelf
//
//  Created by 박태현 on 2023/07/31.
//

import UIKit

final class DetailViewController: UIViewController {

    static let identifier = "DetailViewController"

    @IBOutlet var resultLabel: UILabel!

    private var data: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationItem()
    }

    @objc func didDismissBarButtonTouched(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }

}

private extension DetailViewController {
    func configureUI() {
        resultLabel.text = data?.title ?? ""
    }

    func configureNavigationItem() {
        navigationItem.title = data?.title ?? ""
        let dismissButton = UIBarButtonItem(
            image: .init(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(didDismissBarButtonTouched)
        )
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.leftBarButtonItem?.tintColor = .systemMint
    }
}

extension DetailViewController {
    func configure(with data: Movie) {
        self.data = data
    }
}

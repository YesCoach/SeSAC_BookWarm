//
//  DetailViewController.swift
//  BookShelf
//
//  Created by 박태현 on 2023/07/31.
//

import UIKit

final class DetailViewController: UIViewController {

    static let identifier = "DetailViewController"

    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!

    private var data: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationItem()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enableLargeTitle()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disableLargeTitle()
    }

    @objc func didDismissBarButtonTouched(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }

}

private extension DetailViewController {
    func configureUI() {
        guard let data else { return }
        infoLabel.text = data.info
        overviewLabel.text = data.overview

        posterImageView.image = .init(named: data.posterImageName)
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.opacity = 0.9
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

    func enableLargeTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func disableLargeTitle() {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

extension DetailViewController {
    func configure(with data: Movie) {
        self.data = data
    }
}

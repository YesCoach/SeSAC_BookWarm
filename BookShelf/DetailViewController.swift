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
    @IBOutlet var stackView: UIStackView!

    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.setImage(UIImage(systemName: "star.fill"), for: .selected)
        button.addTarget(self, action: #selector(didFavoriteBarButtonTouched), for: .touchUpInside)
        button.tintColor = .systemMint
        return button
    }()

    private var data: Movie?

    private var completionHandler: ((Bool) -> ())?

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

    @objc func didFavoriteBarButtonTouched(_ sender: UIBarButtonItem) {
        sender.isSelected.toggle()
        completionHandler?(sender.isSelected)
    }
}

private extension DetailViewController {
    func configureUI() {
        guard let data else { return }
        infoLabel.text = data.info
        overviewLabel.text = data.overview
        posterImageView.image = .init(named: data.posterImageName)
        posterImageView.contentMode = .scaleAspectFill
        favoriteButton.isSelected = data.isFavorite

        let spacing = 16.0
        stackView.layoutMargins = .init(
            top: spacing,
            left: spacing,
            bottom: spacing,
            right: spacing
        )
        stackView.isLayoutMarginsRelativeArrangement = true
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

        let favoriteButton = UIBarButtonItem(customView: favoriteButton)
        navigationItem.rightBarButtonItem = favoriteButton

        navigationItem.largeTitleDisplayMode = .automatic
    }

    func enableLargeTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func disableLargeTitle() {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

extension DetailViewController {
    func configure(with data: Movie, completion: @escaping (Bool) -> ()) {
        self.data = data
        completionHandler = completion
    }
}

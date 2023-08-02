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
    @IBOutlet var memoTextView: UITextView!
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var scrollView: UIScrollView!

    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.setImage(UIImage(systemName: "star.fill"), for: .selected)
        button.addTarget(self, action: #selector(didFavoriteBarButtonTouched), for: .touchUpInside)
        button.tintColor = .systemMint
        return button
    }()

    private var data: Movie?
    private let placeHolder = "메모를 입력해보세요"
    private var completionHandler: ((Bool) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
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

    @IBAction func didBackgroundViewTouched(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    @objc func didDismissBarButtonTouched(_ sender: UIBarButtonItem) {
        if navigationController?.modalPresentationStyle == .fullScreen {
            dismiss(animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
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

        memoTextView.setupPlaceHolder(with: placeHolder)
        memoTextView.isScrollEnabled = false
        memoTextView.delegate = self

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

        if navigationController?.modalPresentationStyle == .fullScreen {
            let dismissButton = UIBarButtonItem(
                image: .init(systemName: "xmark"),
                style: .plain,
                target: self,
                action: #selector(didDismissBarButtonTouched)
            )
            navigationItem.leftBarButtonItem = dismissButton
        } else {
            let dismissButton = UIBarButtonItem(
                image: .init(systemName: "chevron.left"),
                style: .plain,
                target: self,
                action: #selector(didDismissBarButtonTouched)
            )
            navigationItem.leftBarButtonItem = dismissButton
        }
        navigationItem.leftBarButtonItem?.tintColor = .systemMint
        let favoriteButton = UIBarButtonItem(customView: favoriteButton)
        navigationItem.rightBarButtonItem = favoriteButton
        navigationItem.largeTitleDisplayMode = .automatic
    }

    func configureLayout() {
        scrollView.bottomAnchor.constraint(
            equalTo: view.keyboardLayoutGuide.topAnchor
        ).isActive = true
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

// MARK: - TextViewDelegate 구현부

extension DetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeHolder {
            textView.text = ""
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.setupPlaceHolder(with: placeHolder)
        }
    }
}

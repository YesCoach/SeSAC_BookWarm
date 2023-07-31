//
//  MainCollectionViewController.swift
//  BookShelf
//
//  Created by 박태현 on 2023/07/31.
//

import UIKit

final class MainCollectionViewController: UICollectionViewController {

    private let userName: String = "고래밥"

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureCollectionView()
    }
}

private extension MainCollectionViewController {
    func configureNavigationItem() {
        navigationItem.title = "\(userName)님의 책장"
    }

    func configureCollectionView() {
        collectionView.register(
            MainCollectionViewCell.self,
            forCellWithReuseIdentifier: MainCollectionViewCell.identifier
        )
    }
}

// MARK: - DataSource 구현부
extension MainCollectionViewController {
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 10
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MainCollectionViewCell.identifier,
            for: indexPath
        ) as? MainCollectionViewCell
        else { return UICollectionViewCell() }

        return cell
    }
}

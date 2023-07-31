//
//  MainCollectionViewController.swift
//  BookShelf
//
//  Created by 박태현 on 2023/07/31.
//

import UIKit

final class MainCollectionViewController: UICollectionViewController {

    private let userName: String = "고래밥"
    private var data: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureCollectionView()
        configureData()
    }
}

private extension MainCollectionViewController {
    func configureNavigationItem() {
        navigationItem.title = "\(userName)님의 책장"
    }

    func configureCollectionView() {
        // Xib -> UINib
        let nib = UINib(nibName: "MainCollectionViewCell", bundle: nil)
        collectionView.register(
            nib,
            forCellWithReuseIdentifier: MainCollectionViewCell.identifier
        )
    }

    func configureData() {
        data = MovieInfo().movie
    }
}

// MARK: - DataSource 구현부
extension MainCollectionViewController {
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return data.count
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

        cell.configure(with: data[indexPath.item])
        return cell
    }
}

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

    @IBAction func didSearchBarButtonTouched(_ sender: UIBarButtonItem) {

        guard let viewController = UIStoryboard(
            name: "Main",
            bundle: nil
        ).instantiateViewController(
            withIdentifier: SearchViewController.identifier
        ) as? SearchViewController
        else { return }

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.modalTransitionStyle = .coverVertical

        present(navigationController, animated: true)
    }
}

private extension MainCollectionViewController {
    func configureNavigationItem() {
        navigationItem.title = "\(userName)님의 책장"
        navigationItem.rightBarButtonItem?.tintColor = .systemMint
    }

    func configureCollectionView() {
        // Xib -> UINib
        let nib = UINib(nibName: "MainCollectionViewCell", bundle: nil)
        collectionView.register(
            nib,
            forCellWithReuseIdentifier: MainCollectionViewCell.identifier
        )

        let flowLayout = UICollectionViewFlowLayout()
        let spacing = 10.0
        let width = UIScreen.main.bounds.width - (spacing * 3)
        flowLayout.itemSize = .init(width: width / 2, height: width / 2)
        flowLayout.sectionInset = UIEdgeInsets(
            top: spacing,
            left: spacing,
            bottom: spacing,
            right: spacing
        )
        flowLayout.minimumLineSpacing = spacing
        flowLayout.minimumInteritemSpacing = spacing

        collectionView.collectionViewLayout = flowLayout
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

        cell.configure(with: data[indexPath.item]) { [weak self] isFavorite in
            self?.data[indexPath.item].isFavorite = isFavorite
        }

        return cell
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let item = data[indexPath.item]

        guard let viewController = UIStoryboard(
            name: "Main",
            bundle: nil
        ).instantiateViewController(
            withIdentifier: DetailViewController.identifier
        ) as? DetailViewController else { return }

        viewController.configure(with: item) { [weak self] isFavorite in
            self?.data[indexPath.item].isFavorite = isFavorite
            self?.collectionView.reloadItems(at: [indexPath])
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
}

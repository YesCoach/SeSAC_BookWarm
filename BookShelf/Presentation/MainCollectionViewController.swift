//
//  MainCollectionViewController.swift
//  BookShelf
//
//  Created by 박태현 on 2023/07/31.
//

import UIKit

final class MainCollectionViewController: UICollectionViewController {

    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(systemName: "star"), for: .normal)
        button.setImage(.init(systemName: "star.fill"), for: .selected)
        button.tintColor = .systemMint
        button.addTarget(self, action: #selector(didFavoriteBarButtonTouched), for: .touchUpInside)
        return button
    }()

    private let userName: String = "고래밥"
    private var data: [Movie] = []
    private var isFavoriteMode: Bool = false {
        didSet {
            collectionView.reloadData()
        }
    }

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

    @objc func didFavoriteBarButtonTouched(_ sender: UIButton) {
        sender.isSelected.toggle()
        isFavoriteMode = sender.isSelected
    }
}

private extension MainCollectionViewController {
    func configureNavigationItem() {
        navigationItem.title = "\(userName)님의 책장"
        navigationItem.rightBarButtonItem?.tintColor = .systemMint

        let favoriteBarButton = UIBarButtonItem(customView: favoriteButton)
        navigationItem.rightBarButtonItems?.append(favoriteBarButton)
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
        return isFavoriteMode ? data.filter { $0.isFavorite }.count : data.count
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

        let movie = isFavoriteMode ?
            data.filter { $0.isFavorite }[indexPath.row] : data[indexPath.row]

        cell.configure(with: movie) { [weak self] isFavorite in
            if let index = self?.data.firstIndex(where: { $0.title == movie.title }) {
                self?.data[index].isFavorite = isFavorite
            }
        }
        return cell
    }
}

// MARK: - CollectionViewDelegate 구현부

extension MainCollectionViewController {
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

        viewController.configure(with: item) { [weak self] movie in
            self?.data[indexPath.item] = movie
            self?.collectionView.reloadItems(at: [indexPath])
        }
        
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}

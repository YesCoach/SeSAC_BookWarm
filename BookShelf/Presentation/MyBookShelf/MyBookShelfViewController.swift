//
//  MyBookShelfViewController.swift
//  BookShelf
//
//  Created by 박태현 on 2023/07/31.
//

import UIKit

enum MainViewMode {
    case whole
    case favorite
    case search
}

final class MyBookShelfViewController: UICollectionViewController {

    private lazy var favoriteBarButton: UIBarButtonItem = {
        let button = UIButton()
        button.setImage(.init(systemName: "star"), for: .normal)
        button.setImage(.init(systemName: "star.fill"), for: .selected)
        button.tintColor = .systemMint
        button.addTarget(self, action: #selector(didFavoriteBarButtonTouched), for: .touchUpInside)

        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }()

    private lazy var searchBarButton: UIBarButtonItem = {
        let button = UIButton()
        button.setImage(.init(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .systemMint
        button.addTarget(self, action: #selector(didSearchBarButtonTouched), for: .touchUpInside)

        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }()

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.tintColor = .systemMint
        return searchBar
    }()

    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(
            target: self,
            action: #selector(didBackgroundViewTouched)
        )
        return gesture
    }()

    private let userName: String = "고래밥"
    private var data: [Movie] = []

    private var contentMode: MainViewMode = .whole {
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
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

    @objc func didSearchCancelButtonTouched(_ sender: UIButton) {
        contentMode = .whole
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }

    @objc func didFavoriteBarButtonTouched(_ sender: UIButton) {
        sender.isSelected.toggle()
        searchBar.resignFirstResponder()
        contentMode = sender.isSelected ? .favorite : .whole
    }

    @objc func didBackgroundViewTouched(_ sender: UITapGestureRecognizer) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - Private Method

private extension MyBookShelfViewController {
    func configureNavigationItem() {
        navigationItem.title = "\(userName)님의 책장"
        navigationItem.titleView = searchBar

        navigationItem.rightBarButtonItems = [searchBarButton, favoriteBarButton]

        navigationItem.hidesSearchBarWhenScrolling = true
    }

    func configureCollectionView() {
        // Xib -> UINib
        let nib = UINib(nibName: MyBookShelfCollectionViewCell.identifier, bundle: nil)
        collectionView.register(
            nib,
            forCellWithReuseIdentifier: MyBookShelfCollectionViewCell.identifier
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

    func addTapGesture() {
        view.addGestureRecognizer(tapGesture)
    }

    func removeTapGesture() {
        view.removeGestureRecognizer(tapGesture)
    }

    func configureData() {
        data = MovieInfo().movie
    }
}

// MARK: - DataSource 구현부

extension MyBookShelfViewController {
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        switch contentMode {
        case .whole: return data.count
        case .favorite: return data.filter { $0.isFavorite }.count
        case .search: return data.filter { $0.title.contains(searchBar.text!) }.count
        }
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MyBookShelfCollectionViewCell.identifier,
            for: indexPath
        ) as? MyBookShelfCollectionViewCell
        else { return UICollectionViewCell() }

        var movie: Movie

        switch contentMode {
        case .whole:
            movie = data[indexPath.row]
        case .favorite:
            movie = data.filter { $0.isFavorite }[indexPath.row]
        case .search:
            movie = data.filter { $0.title.contains(searchBar.text!) }[indexPath.row]
        }

        cell.configure(with: movie) { [weak self] isFavorite in
            if let index = self?.data.firstIndex(where: { $0.title == movie.title }) {
                self?.data[index].isFavorite = isFavorite
            }
        }
        return cell
    }
}

// MARK: - CollectionViewDelegate 구현부

extension MyBookShelfViewController {
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

// MARK: - UISearchBarDelegate 구현부

extension MyBookShelfViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = !searchText.isEmpty
        favoriteBarButton.isHidden = !searchText.isEmpty
        guard searchText.isEmpty == false
        else {
            contentMode = .whole
            return
        }
        contentMode = .search
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        contentMode = .whole
        searchBar.showsCancelButton = false
        favoriteBarButton.isHidden = false
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        addTapGesture()
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        removeTapGesture()
        return true
    }
}

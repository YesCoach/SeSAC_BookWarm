//
//  HomeViewController.swift
//  BookShelf
//
//  Created by 박태현 on 2023/08/02.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet var homeItemTableView: UITableView!
    @IBOutlet var recentItemCollectionView: UICollectionView!

    private var data: [Movie] = MovieInfo().movie
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

private extension HomeViewController {
    func configureUI() {
        navigationItem.title = "둘러보기"
        configureTableView()
        configureCollectionView()
    }

    func configureTableView() {
        let nib = UINib(nibName: HomeItemTableViewCell.identifier, bundle: nil)
        homeItemTableView.register(nib, forCellReuseIdentifier: HomeItemTableViewCell.identifier)

        homeItemTableView.dataSource = self
        homeItemTableView.delegate = self

        homeItemTableView.rowHeight = 120.0
        homeItemTableView.separatorInset = .init(top: 0, left: 20, bottom: 0, right: 20)
    }

    func configureCollectionView() {
        let nib = UINib(nibName: RecentItemCollectionViewCell.identifier, bundle: nil)
        recentItemCollectionView.register(
            nib, forCellWithReuseIdentifier: RecentItemCollectionViewCell.identifier
        )

        recentItemCollectionView.dataSource = self
        recentItemCollectionView.delegate = self
        recentItemCollectionView.scrollIndicatorInsets = .init(top: 0, left: 0, bottom: -5, right: 0)

        let layout = UICollectionViewFlowLayout()
        let spacing = 10.0
        let width = UIScreen.main.bounds.width - (spacing * 5)
        let height = recentItemCollectionView.frame.height
        layout.itemSize = .init(width: width / 4, height: height - (spacing * 2))
        layout.sectionInset = UIEdgeInsets(
            top: spacing,
            left: spacing,
            bottom: spacing,
            right: spacing
        )
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .horizontal

        recentItemCollectionView.collectionViewLayout = layout
    }
}

// MARK: - TableView DataSource 구현부

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: HomeItemTableViewCell.identifier,
            for: indexPath
        ) as? HomeItemTableViewCell
        else { return UITableViewCell() }

        cell.configure(with: data[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "요즘 인기 작품"
        }
        return nil
    }
}

// MARK: - TableView Delegate 구현부

extension HomeViewController: UITableViewDelegate {

}


// MARK: - CollectionView DataSource 구현부

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return data.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecentItemCollectionViewCell.identifier,
            for: indexPath
        ) as? RecentItemCollectionViewCell
        else { return UICollectionViewCell() }

        cell.configure(with: data[indexPath.item])

        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {

}

//
//  HomeViewController.swift
//  BookShelf
//
//  Created by 박태현 on 2023/08/02.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var recentCollectionView: UICollectionView!

    private var data: [Movie] = MovieInfo().movie
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
}

private extension HomeViewController {
    func configureTableView() {
        let nib = UINib(nibName: HomeItemTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: HomeItemTableViewCell.identifier)

        tableView.dataSource = self
        tableView.delegate = self

        tableView.rowHeight = 120.0
        tableView.separatorInset = .init(top: 0, left: 80, bottom: 0, right: 20)
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
}

// MARK: - TableView Delegate 구현부

extension HomeViewController: UITableViewDelegate {

}

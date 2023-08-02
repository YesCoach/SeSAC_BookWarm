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
        homeItemTableView.separatorStyle = .none
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


    /// 셀 선택시 해당 아이템의 상세화면으로 이동하는 메서드.
    /// - Parameter indexPath: 선택한 셀의 indexPath입니다.
    func didSelectCell(at indexPath: IndexPath) {
        let movie = data[indexPath.row]
        guard let viewController = storyboard?.instantiateViewController(
            identifier: DetailViewController.identifier
        ) as? DetailViewController
        else { return }

        viewController.configure(with: movie) { [weak self] isFavorite in
            self?.data[indexPath.row].isFavorite = isFavorite
        }

        let navigationVC = UINavigationController(rootViewController: viewController)
        navigationVC.modalPresentationStyle = .fullScreen
        present(navigationVC, animated: true)
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

    // Custom Header View를 구현해서, 원하는 section에 넣어주는 작업.
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = HomeItemTableHeaderView()
            header.configure(with: .popluar)
            return header
        }
        return UIView()
    }

    // tableView의 grouped style을 사용해야, section header가 sticky하게 고정되지 않음.
    // section 별로 원하는 높이를 지정해야 함.
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40
        }
        return .leastNonzeroMagnitude
    }

    // tableview의 grouped style은 section마다 header와 footer가 default로 들어가기 때문에
    // header나 footer를 사용하지 않는 section에 대해서 높이 처리가 필요하다.
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
}

// MARK: - TableView Delegate 구현부

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectCell(at: indexPath)
    }
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

// MARK: - CollectionView Delegate 구현부

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        didSelectCell(at: indexPath)
    }
}

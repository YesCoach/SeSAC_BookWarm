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
    }
}

private extension MainCollectionViewController {
    func configureNavigationItem() {
        navigationItem.title = "\(userName)님의 책장"
    }
}

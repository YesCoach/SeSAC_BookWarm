//
//  SearchViewController.swift
//  BookShelf
//
//  Created by 박태현 on 2023/07/31.
//

import UIKit
import Alamofire
import SwiftyJSON

final class SearchViewController: UIViewController {

    static let identifier = "SearchViewController"

    // MARK: - UI Components

    @IBOutlet var tableView: UITableView!
    @IBOutlet var emptyLabel: UILabel!
    @IBOutlet var indicatorView: UIActivityIndicatorView!

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "제목을 입력하세요."
        searchBar.searchTextField.addTarget(
            self,
            action: #selector(didKeyboardReturnButtonTouched),
            for: .editingDidEndOnExit
        )
        searchBar.delegate = self
        return searchBar
    }()

    // MARK: - Properties

    private var dataList: [Book] = [] {
        didSet {
            tableView.reloadData()
            emptyLabel.isHidden = !dataList.isEmpty
        }
    }
    private var page = 1
    private var isEnd = false
    private var searchKeyword: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationItem()
    }

    @objc func didDismissButtonTouched(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

    @IBAction func didBackgroundViewTouched(_ sender: UITapGestureRecognizer) {
        searchBar.resignFirstResponder()
    }

    @objc func didKeyboardReturnButtonTouched(_ sender: UITextField) {
        searchBar.resignFirstResponder()
    }
}

private extension SearchViewController {

    func configureUI() {
        let nib = UINib(nibName: SearchTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.keyboardDismissMode = .onDrag
        tableView.rowHeight = 180.0
        emptyLabel.font = .systemFont(ofSize: 16, weight: .regular)
        emptyLabel.text = "검색 결과가 없어요!"

        indicatorView.isHidden = true
    }

    func configureNavigationItem() {
        let dismissButton = UIBarButtonItem(
            image: .init(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(didDismissButtonTouched)
        )
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.leftBarButtonItem?.tintColor = .systemMint

        navigationItem.titleView = searchBar
    }

    func fetchData(with keyword: String, page: Int) {
        // Request Header
        let headers: HTTPHeaders = .init(["Authorization": "KakaoAK \(APIKey.kakaoKey)"])
        // Query Value
        let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        let url = "https://dapi.kakao.com/v3/search/book?query=\(encodedKeyword)&page=\(page)"

        indicatorView.startAnimating()
        indicatorView.isHidden = false
        AF.request(
            url,
            method: .get,
            headers: headers
        )
        .validate()
        .responseJSON { [weak self] response in
            self?.indicatorView.stopAnimating()
            self?.indicatorView.isHidden = true
            switch response.result {
            case .success(let value):
                let json = JSON(value)

                self?.isEnd = json["meta"]["is_end"].boolValue

                let data = json["documents"].map({ (str, json) in
                    let book = Book(
                        title: json["title"].stringValue,
                        authors: json["authors"].map{ (_, json) in
                            json.stringValue
                        },
                        contents: json["contents"].stringValue,
                        price: json["price"].intValue,
                        salePrice: json["sale_price"].intValue,
                        status: json["status"].stringValue,
                        thumbnail: json["thumbnail"].stringValue,
                        translators: json["translators"].map{ (_, json) in
                            json.stringValue
                        }
                    )
                    return book
                })

                self?.dataList.append(contentsOf: data)

            case .failure(let error):
                print(error)
            }
        }
    }

}

// MARK: - UITableViewDataSource 구현부

extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchTableViewCell.identifier,
            for: indexPath
        ) as? SearchTableViewCell
        else { return UITableViewCell() }

        cell.configure(with: dataList[indexPath.row])

        return cell
    }

}

// MARK: - UITableViewDataSourcePrefetching 구현부

extension SearchViewController: UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.row == dataList.count - 1 && page < 50 && !isEnd {
                page += 1
                fetchData(with: searchKeyword, page: page)
            }
        }
    }

    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("====취소: \(indexPaths)")
    }

}

// MARK: - SearchBarDelegate

extension SearchViewController: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        page = 1
        isEnd = false
        searchKeyword = searchBar.text!
        dataList = []
        fetchData(with: searchKeyword, page: page)
    }

}

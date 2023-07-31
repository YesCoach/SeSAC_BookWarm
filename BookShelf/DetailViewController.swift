//
//  DetailViewController.swift
//  BookShelf
//
//  Created by 박태현 on 2023/07/31.
//

import UIKit

final class DetailViewController: UIViewController {

    static let identifier = "DetailViewController"

    @IBOutlet var resultLabel: UILabel!

    private var data: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

private extension DetailViewController {
    func configureUI() {
        resultLabel.text = data?.title ?? ""
    }
}

extension DetailViewController {
    func configure(with data: Movie) {
        self.data = data
    }
}

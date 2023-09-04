//
//  DIContainer.swift
//  BookShelf
//
//  Created by 박태현 on 2023/09/04.
//

import Foundation

final class DIContainer {

    static let shared = DIContainer(dependencies: Dependencies(apiDataTransferService: .shared))

    struct Dependencies {
        let apiDataTransferService: NetworkManager
    }

    private let dependencies: Dependencies

    // MARK: - Persistent Storage

    lazy var bookStorage: BookStorage = RealmBookStorage(realmStorage: .shared)

    // MARK: - Initializer

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func makeSearchBookUseCase() -> SearchBookUseCase {
        return DefaultSearchBookUseCase(bookRepository: makeBookRepository())
    }

    func makeBookRepository() -> BookRepository {
        return DefaultBookRepository(
            networkManager: dependencies.apiDataTransferService,
            bookStorage: bookStorage
        )
    }
}

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

    // MARK: - UseCase

    func makeSearchBookUseCase() -> SearchBookUseCase {
        return DefaultSearchBookUseCase(bookRepository: makeBookRepository())
    }

    func makeLocalBookUseCase() -> LocalBookUseCase {
        return DefaultLocalBookUseCase(localBookRepository: makeLocalBookRepository())
    }

    // MARK: - Repository

    func makeBookRepository() -> BookRepository {
        return DefaultBookRepository(
            networkManager: dependencies.apiDataTransferService
        )
    }

    func makeLocalBookRepository() -> LocalBookRepository {
        return DefaultLocalBookRepository(
            bookStorage: RealmBookStorage(realmStorage: .shared)
        )
    }
}

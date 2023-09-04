//
//  AppDIContainer.swift
//  BookShelf
//
//  Created by 박태현 on 2023/09/04.
//

import Foundation

final class AppDIContainer {

    // MARK: - DIContainers
    func makeDIContainer() -> DIContainer {
        let dependencies = DIContainer.Dependencies(apiDataTransferService: .shared)

        return DIContainer(dependencies: dependencies)
    }
}


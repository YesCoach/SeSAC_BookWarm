//
//  RealmMapping.swift
//  BookShelf
//
//  Created by 박태현 on 2023/09/04.
//

import Foundation

protocol RealmMapping {
    associatedtype DomainType

    func toDomain() -> DomainType
}

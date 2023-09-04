//
//  RealmStorage.swift
//  BookShelf
//
//  Created by 박태현 on 2023/09/04.
//

import Foundation
import RealmSwift

final class RealmStorage {

    static let shared = RealmStorage()

    private let realm = try! Realm()

    private init() { }

}

extension RealmStorage {

    func createData<T: Object>(data: T) {
        try! realm.write {
            realm.add(data)
            print("Realm Add Succeed")
        }
    }

    func readData<T: Object>(_ object: T.Type) -> Results<T> {
        return realm
                    .objects(object)
                    .sorted(byKeyPath: "title", ascending: true)
    }

}

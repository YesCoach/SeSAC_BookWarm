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
        do {
            try realm.write {
                realm.add(data)
                print("Realm Add Succeed")
            }
        } catch {
            debugPrint(error)
        }
    }

    func readData<T: Object>(_ object: T.Type) -> Results<T> {
        return realm
            .objects(object)
            .sorted(byKeyPath: "title", ascending: true)
    }

    func updateData<T: Object>(data: T, completion: ((T) -> ())) {
        do {
            try realm.write {
                completion(data)
                realm.add(data, update: .modified)
                print("Realm update completed")
            }
        } catch {
            debugPrint(error)
        }
    }

    func deledeData<T: Object>(data: T) {
        do {
            try realm.write {
                realm.delete(data)
                print("Realm delete completed")
            }
        } catch {
            debugPrint(error)
        }
    }

}

//
//  AppDelegate.swift
//  BookShelf
//
//  Created by 박태현 on 2023/07/31.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let config = Realm.Configuration(schemaVersion: 5) { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {
                // Auto Migration - 새로운 컬럼 추가(isAlreadyRead)
            }
            if oldSchemaVersion < 2 {
                // Auto Migration - 기존 컬럼 삭제(isAlreadyRead)
            }
            if oldSchemaVersion < 3 {
                // Manual Migration - 기존 컬럼명 변경
                migration.renameProperty(
                    onType: BookEntity.className(),
                    from: "isFavorite",
                    to: "favorite"
                )
            }
            if oldSchemaVersion < 4 {
                // Manual Migration - 기존의 컬럼을 결합하여 새로운 컬럼 생성
                migration.enumerateObjects(ofType: BookEntity.className()) { oldObject, newObject in
                    guard let oldObject, let newObject else { return }
                    // 새로운 컬럼에 기존의 컬럼 값들을 결합
                    newObject["titlePrice"] = "\(oldObject["title"])\(oldObject["price"])"
                }
            }
            if oldSchemaVersion < 5 {
                migration.enumerateObjects(ofType: BookEntity.className()) { oldObject, newObject in
                    guard let newObject else { return }
                    newObject["isAlreadyRead"] = false
                }
            }
        }

        Realm.Configuration.defaultConfiguration = config

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


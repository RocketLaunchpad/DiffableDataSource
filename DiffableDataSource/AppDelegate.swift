//
//  AppDelegate.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/24/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        // Create one tab per strategy.
        let tabs = [
            UINavigationController(rootViewController:
                DefaultTableViewController().then {
                    $0.strategy = AnySnapshotStrategy(EditSnapshot())
                    $0.title = "Edit Table View Snapshot"
                }).then {
                    $0.tabBarItem.image = UIImage(systemName: "pencil.circle")
                    $0.tabBarItem.selectedImage = UIImage(systemName: "pencil.circle.fill")
                    $0.tabBarItem.title = "Edit TV"
                },

            UINavigationController(rootViewController:
                DefaultCollectionViewController().then {
                    $0.strategy = AnySnapshotStrategy(EditSnapshot())
                    $0.title = "Edit Collection View Snapshot"
                }).then {
                    $0.tabBarItem.image = UIImage(systemName: "pencil.circle")
                    $0.tabBarItem.selectedImage = UIImage(systemName: "pencil.circle.fill")
                    $0.tabBarItem.title = "Edit CV"
                },

            UINavigationController(rootViewController:
                DefaultTableViewController().then {
                    $0.strategy = AnySnapshotStrategy(RecreateSnapshot())
                    $0.title = "Recreate Table View Snapshot"
                }).then {
                    $0.tabBarItem.image = UIImage(systemName: "repeat.circle")
                    $0.tabBarItem.selectedImage = UIImage(systemName: "repeat.circle.fill")
                    $0.tabBarItem.title = "Recreate TV"
                },

            UINavigationController(rootViewController:
                DefaultCollectionViewController().then {
                    $0.strategy = AnySnapshotStrategy(RecreateSnapshot())
                    $0.title = "Recreate Collection View Snapshot"
                }).then {
                    $0.tabBarItem.image = UIImage(systemName: "repeat.circle")
                    $0.tabBarItem.selectedImage = UIImage(systemName: "repeat.circle.fill")
                    $0.tabBarItem.title = "Recreate CV"
                },
        ]

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = tabs

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()

        return true
    }
}

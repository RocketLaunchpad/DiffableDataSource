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
                    $0.title = "Table View"
                }).then {
                    $0.tabBarItem.image = UIImage(systemName: "tablecells")
                    $0.tabBarItem.selectedImage = UIImage(systemName: "tablecells.fill")
                    $0.tabBarItem.title = "Table"
                },

            UINavigationController(rootViewController:
                DefaultCollectionViewController().then {
                    $0.title = "Collection View"
                }).then {
                    $0.tabBarItem.image = UIImage(systemName: "tablecells")
                    $0.tabBarItem.selectedImage = UIImage(systemName: "tablecells.fill")
                    $0.tabBarItem.title = "Collection"
                },
        ]

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = tabs

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()

        return true
    }
}

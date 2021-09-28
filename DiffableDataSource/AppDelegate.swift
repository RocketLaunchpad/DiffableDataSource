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
                DefaultViewController().then {
                    // Configure the view controller & its strategy.
                    $0.strategy = EditSnapshot()
                    $0.title = "Edit Snapshot"
                }).then {
                    // Configure the navigation controller's tab bar item.
                    $0.tabBarItem.image = UIImage(systemName: "pencil.circle")
                    $0.tabBarItem.selectedImage = UIImage(systemName: "pencil.circle.fill")
                    $0.tabBarItem.title = "Edit"
                },

            UINavigationController(rootViewController:
                DefaultViewController().then {
                    // Configure the view controller & its strategy.
                    $0.strategy = RecreateSnapshot()
                    $0.title = "Recreate Snapshot"
                }).then {
                    // Configure the navigation controller's tab bar item.
                    $0.tabBarItem.image = UIImage(systemName: "repeat.circle")
                    $0.tabBarItem.image = UIImage(systemName: "repeat.circle.fill")
                    $0.tabBarItem.title = "Recreate"
                }
        ]

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = tabs

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()

        return true
    }
}

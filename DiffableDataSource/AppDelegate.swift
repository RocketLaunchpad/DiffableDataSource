//
//  AppDelegate.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/24/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // Need to retain here as it is not retained by the view controller
    let defaultViewControllerDelegate = SnapshotEditingDelegate()

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        let vc = DefaultViewController()
        vc.delegate = defaultViewControllerDelegate

        let nc = UINavigationController(rootViewController: vc)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()

        return true
    }
}

//
//  AppDelegate.swift
//  DiffableDataSource
//
//  Copyright (c) 2021 Rocket Insights, Inc.
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
//  DEALINGS IN THE SOFTWARE.
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

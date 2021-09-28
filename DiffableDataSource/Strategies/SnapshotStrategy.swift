//
//  SnapshotStrategy.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/28/21.
//

import UIKit

protocol SnapshotStrategy {

    func insert(_ model: AnyTableViewCellModel, after selectedItem: AnyTableViewCellModel, in dataSource: DefaultTableViewController.DataSourceType)

    func append(_ model: AnyTableViewCellModel, toSection section: DefaultTableViewControllerSection, in dataSource: DefaultTableViewController.DataSourceType)
}

extension SnapshotStrategy {

    func insertOrAppend(_ model: AnyTableViewCellModel,
                        after selectedItem: AnyTableViewCellModel?,
                        orAtEndOf section: DefaultTableViewControllerSection,
                        in dataSource: DefaultTableViewController.DataSourceType) {

        if let item = selectedItem {
            insert(model, after: item, in: dataSource)
        }
        else {
            append(model, toSection: section, in: dataSource)
        }
    }
}

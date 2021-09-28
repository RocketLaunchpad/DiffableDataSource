//
//  SnapshotStrategy.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/28/21.
//

import UIKit

/// This enables us to demonstrate both "Edit Snapshot" and "Recreate Snapshot" strategies from a single view controller.
protocol SnapshotStrategy {

    /// Insert the specified model after the selected model in the specified data source.
    func insert(_ model: AnyTableViewCellModel, after selectedItem: AnyTableViewCellModel, in dataSource: DefaultTableViewController.DataSourceType)

    /// Append the specified model at the end of the specified section in the specified data source.
    func append(_ model: AnyTableViewCellModel, toSection section: DefaultTableViewControllerSection, in dataSource: DefaultTableViewController.DataSourceType)
}

extension SnapshotStrategy {

    /**
     Inserts or appends the specified model.

     - If `selectedItem` is not `nil`, the new model is inserted after the selected item in the data source.
     - If `selectedItem` is `nil`, the new model is appended to the end of the specified section.
     */
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

//
//  EditSnapshot.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/28/21.
//

import UIKit

/// Strategy to edit a snapshot in place.
class EditSnapshot: SnapshotStrategy {

    func insert(_ model: AnyTableViewCellModel, after selectedItem: AnyTableViewCellModel, in dataSource: DefaultTableViewController.DataSourceType) {
        var snapshot = dataSource.snapshot()
        snapshot.insertItems([model], afterItem: selectedItem)
        dataSource.apply(snapshot)
    }

    func append(_ model: AnyTableViewCellModel, toSection section: DefaultTableViewControllerSection, in dataSource: DefaultTableViewController.DataSourceType) {
        var snapshot = dataSource.snapshot()

        if !snapshot.sectionIdentifiers.contains(section) {
            snapshot.appendSections([section])
        }
        snapshot.appendItems([model], toSection: section)
        dataSource.apply(snapshot)
    }
}

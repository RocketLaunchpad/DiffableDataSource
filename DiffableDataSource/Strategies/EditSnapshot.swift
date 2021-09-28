//
//  EditSnapshot.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/28/21.
//

import UIKit

class EditSnapshot: SnapshotStrategy {

    func insert(_ model: AnyCellModel, after selectedItem: AnyCellModel, in dataSource: DefaultViewController.DataSourceType) {
        var snapshot = dataSource.snapshot()
        snapshot.insertItems([model], afterItem: selectedItem)
        dataSource.apply(snapshot)
    }

    func append(_ model: AnyCellModel, toSection section: DefaultViewControllerSection, in dataSource: DefaultViewController.DataSourceType) {
        var snapshot = dataSource.snapshot()

        if !snapshot.sectionIdentifiers.contains(section) {
            snapshot.appendSections([section])
        }
        snapshot.appendItems([model], toSection: section)
        dataSource.apply(snapshot)
    }
}

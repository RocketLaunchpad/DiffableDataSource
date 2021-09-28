//
//  SnapshotEditingDelegate.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/28/21.
//

import UIKit

class SnapshotEditingDelegate: DefaultViewControllerDelegate {

    private typealias DataSourceType = DefaultViewController.DataSourceType

    func defaultViewController(_ sender: DefaultViewController,
                               insertOrAppend model: AnyCellModel,
                               after selection: AnyCellModel?,
                               orAtEndOf section: DefaultViewControllerSection) {
        if let selection = selection {
            insert(model, after: selection, in: sender.dataSource)
        }
        else {
            append(model, toSection: section, in: sender.dataSource)
        }
    }

    private func insert(_ model: AnyCellModel, after selectedItem: AnyCellModel, in dataSource: DataSourceType) {
        var snapshot = dataSource.snapshot()
        snapshot.insertItems([model], afterItem: selectedItem)
        dataSource.apply(snapshot)
    }

    private func append(_ model: AnyCellModel, toSection section: DefaultViewControllerSection, in dataSource: DataSourceType) {
        var snapshot = dataSource.snapshot()

        if !snapshot.sectionIdentifiers.contains(section) {
            snapshot.appendSections([section])
        }
        snapshot.appendItems([model], toSection: section)
        dataSource.apply(snapshot)
    }
}

//
//  SnapshotStrategy.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/28/21.
//

import UIKit

protocol SnapshotStrategy {

    func insert(_ model: AnyCellModel, after selectedItem: AnyCellModel, in dataSource: DefaultViewController.DataSourceType)

    func append(_ model: AnyCellModel, toSection section: DefaultViewControllerSection, in dataSource: DefaultViewController.DataSourceType)
}

extension SnapshotStrategy {

    func insertOrAppend(_ model: AnyCellModel,
                        after selectedItem: AnyCellModel?,
                        orAtEndOf section: DefaultViewControllerSection,
                        in dataSource: DefaultViewController.DataSourceType) {

        if let item = selectedItem {
            insert(model, after: item, in: dataSource)
        }
        else {
            append(model, toSection: section, in: dataSource)
        }
    }
}

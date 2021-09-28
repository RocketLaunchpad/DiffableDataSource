//
//  RecreateSnapshot.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/28/21.
//

import UIKit

class RecreateSnapshot: SnapshotStrategy {

    private var imageSectionContents: [AnyTableViewCellModel] = []

    private var textSectionContents: [AnyTableViewCellModel] = []

    func insert(_ model: AnyTableViewCellModel, after selectedItem: AnyTableViewCellModel, in dataSource: DefaultTableViewController.DataSourceType) {
        if let index = imageSectionContents.firstIndex(of: selectedItem) {
            imageSectionContents.insert(model, at: index + 1)
        }
        else if let index = textSectionContents.firstIndex(of: selectedItem) {
            textSectionContents.insert(model, at: index + 1)
        }
        else {
            preconditionFailure("Cannot find selected item")
        }

        createAndApplySnapshot(dataSource: dataSource)
    }

    func append(_ model: AnyTableViewCellModel, toSection section: DefaultTableViewControllerSection, in dataSource: DefaultTableViewController.DataSourceType) {
        switch section {
        case .defaultImageSection:
            imageSectionContents.append(model)

        case .defaultTextSection:
            textSectionContents.append(model)
        }

        createAndApplySnapshot(dataSource: dataSource)
    }

    private func createAndApplySnapshot(dataSource: DefaultTableViewController.DataSourceType) {
        var snapshot = DefaultTableViewController.SnapshotType()
        snapshot.appendSections(DefaultTableViewControllerSection.allCases)

        snapshot.appendItems(imageSectionContents, toSection: .defaultImageSection)
        snapshot.appendItems(textSectionContents, toSection: .defaultTextSection)

        dataSource.apply(snapshot)
    }
}

//
//  RecreateSnapshot.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/28/21.
//

import UIKit

class RecreateSnapshot: SnapshotStrategy {

    private var imageSectionContents: [AnyCellModel] = []

    private var textSectionContents: [AnyCellModel] = []

    func insert(_ model: AnyCellModel, after selectedItem: AnyCellModel, in dataSource: DefaultViewController.DataSourceType) {
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

    func append(_ model: AnyCellModel, toSection section: DefaultViewControllerSection, in dataSource: DefaultViewController.DataSourceType) {
        switch section {
        case .defaultImageSection:
            imageSectionContents.append(model)

        case .defaultTextSection:
            textSectionContents.append(model)
        }

        createAndApplySnapshot(dataSource: dataSource)
    }

    private func createAndApplySnapshot(dataSource: DefaultViewController.DataSourceType) {
        var snapshot = DefaultViewController.SnapshotType()
        snapshot.appendSections(DefaultViewControllerSection.allCases)

        snapshot.appendItems(imageSectionContents, toSection: .defaultImageSection)
        snapshot.appendItems(textSectionContents, toSection: .defaultTextSection)

        dataSource.apply(snapshot)
    }
}

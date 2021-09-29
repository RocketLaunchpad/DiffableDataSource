//
//  RecreateSnapshot.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/28/21.
//

import UIKit

/// Strategy to recreate a snapshot from scratch every time a change is made. This is mainly intended to demonstrate that you can recreate the entire snapshot and the diffable data source will still correctly handle the updates.
class RecreateSnapshot<SectionIdentifierType, ItemIdentifierType>: SnapshotStrategy
where SectionIdentifierType: Hashable & CaseIterable, ItemIdentifierType: Hashable {

    typealias DiffableDataSourceType = AnyDiffableDataSource<SectionIdentifierType, ItemIdentifierType>

    var dataSource: DiffableDataSourceType

    private var sections: [SectionIdentifierType: [ItemIdentifierType]] = [:]

    init<T>(dataSource: T)
    where T: DiffableDataSource, T.SectionIdentifierType == SectionIdentifierType, T.ItemIdentifierType == ItemIdentifierType {
        self.dataSource = AnyDiffableDataSource(dataSource)
    }

    private func firstSection(containing element: ItemIdentifierType) -> SectionIdentifierType? {
        for (section, elements) in sections {
            if elements.contains(element) {
                return section
            }
        }
        return nil
    }

    func insert(_ model: ItemIdentifierType, after selectedItem: ItemIdentifierType, in dataSource: AnyDiffableDataSource<SectionIdentifierType, ItemIdentifierType>) {

        guard let section = firstSection(containing: selectedItem) else {
            preconditionFailure("Cannot find selected item")
        }

        var elements = sections[section] ?? []
        elements.append(model)
        sections[section] = elements

        createAndApplySnapshot()
    }

    func append(_ model: ItemIdentifierType, toSection section: SectionIdentifierType, in dataSource: AnyDiffableDataSource<SectionIdentifierType, ItemIdentifierType>) {

        var elements = sections[section] ?? []
        elements.append(model)
        sections[section] = elements

        createAndApplySnapshot()
    }

    private func createAndApplySnapshot() {
        var snapshot = dataSource.snapshot()

        for section in SectionIdentifierType.allCases {
            let elements = sections[section] ?? []
            if !elements.isEmpty {
                snapshot.appendItems(elements, toSection: section)
            }
        }

        dataSource.apply(snapshot)
    }
}

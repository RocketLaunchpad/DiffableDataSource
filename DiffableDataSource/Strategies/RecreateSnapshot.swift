//
//  RecreateSnapshot.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/28/21.
//

import UIKit

/// Strategy to recreate a snapshot from scratch every time a change is made. This is mainly intended to demonstrate that you can recreate the entire snapshot and the diffable data source will still correctly handle the updates.
class RecreateSnapshot<SectionIdentifierType, ItemIdentifierType>: SnapshotStrategy
where SectionIdentifierType: Hashable & CaseIterable, ItemIdentifierType: Hashable
{
    private typealias SnapshotType = NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>

    private var sections: [SectionIdentifierType: [ItemIdentifierType]] = [:]

    private func firstSection(containing element: ItemIdentifierType) -> SectionIdentifierType? {
        for (section, elements) in sections {
            if elements.contains(element) {
                return section
            }
        }
        return nil
    }

    func insert<DiffableDataSourceType>(_ model: ItemIdentifierType, after selectedItem: ItemIdentifierType, in dataSource: DiffableDataSourceType)
    where DiffableDataSourceType : DiffableDataSource,
          ItemIdentifierType == DiffableDataSourceType.ItemIdentifierType,
          SectionIdentifierType == DiffableDataSourceType.SectionIdentifierType
    {

        guard let section = firstSection(containing: selectedItem) else {
            preconditionFailure("Cannot find selected item")
        }

        var elements = sections[section] ?? []
        elements.append(model)
        sections[section] = elements

        createAndApplySnapshot(in: dataSource)
    }

    func append<DiffableDataSourceType>(_ model: ItemIdentifierType, toSection section: SectionIdentifierType, in dataSource: DiffableDataSourceType)
    where DiffableDataSourceType : DiffableDataSource,
          ItemIdentifierType == DiffableDataSourceType.ItemIdentifierType,
          SectionIdentifierType == DiffableDataSourceType.SectionIdentifierType
    {
        var elements = sections[section] ?? []
        elements.append(model)
        sections[section] = elements

        createAndApplySnapshot(in: dataSource)
    }

    private func createAndApplySnapshot<DiffableDataSourceType>(in dataSource: DiffableDataSourceType)
    where DiffableDataSourceType : DiffableDataSource,
          ItemIdentifierType == DiffableDataSourceType.ItemIdentifierType,
          SectionIdentifierType == DiffableDataSourceType.SectionIdentifierType
    {
        var snapshot = SnapshotType()

        for section in SectionIdentifierType.allCases {
            snapshot.appendSections([section])
            snapshot.appendItems(sections[section] ?? [], toSection: section)
        }

        dataSource.apply(snapshot)
    }
}

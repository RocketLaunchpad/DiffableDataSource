//
//  EditSnapshot.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/28/21.
//

import UIKit

/// Strategy to edit a snapshot in place.
class EditSnapshot<SectionIdentifierType, ItemIdentifierType>: SnapshotStrategy
where SectionIdentifierType: Hashable, ItemIdentifierType: Hashable
{
    func insert<DiffableDataSourceType>(_ model: ItemIdentifierType, after selectedItem: ItemIdentifierType, in dataSource: DiffableDataSourceType)
    where DiffableDataSourceType : DiffableDataSource,
          ItemIdentifierType == DiffableDataSourceType.ItemIdentifierType,
          SectionIdentifierType == DiffableDataSourceType.SectionIdentifierType
    {
        var snapshot = dataSource.snapshot()
        snapshot.insertItems([model], afterItem: selectedItem)
        dataSource.apply(snapshot)
    }

    func append<DiffableDataSourceType>(_ model: ItemIdentifierType, toSection section: SectionIdentifierType, in dataSource: DiffableDataSourceType)
    where DiffableDataSourceType : DiffableDataSource,
          ItemIdentifierType == DiffableDataSourceType.ItemIdentifierType,
          SectionIdentifierType == DiffableDataSourceType.SectionIdentifierType
    {
        var snapshot = dataSource.snapshot()

        if !snapshot.sectionIdentifiers.contains(section) {
            snapshot.appendSections([section])
        }
        snapshot.appendItems([model], toSection: section)
        dataSource.apply(snapshot)
    }
}

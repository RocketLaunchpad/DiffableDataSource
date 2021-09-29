//
//  EditSnapshot.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/28/21.
//

import UIKit

/// Strategy to edit a snapshot in place.
class EditSnapshot<SectionIdentifierType, ItemIdentifierType>: SnapshotStrategy
where SectionIdentifierType: Hashable, ItemIdentifierType: Hashable {

    typealias DiffableDataSourceType = AnyDiffableDataSource<SectionIdentifierType, ItemIdentifierType>

    var dataSource: DiffableDataSourceType

    init<T>(dataSource: T)
    where T: DiffableDataSource, T.SectionIdentifierType == SectionIdentifierType, T.ItemIdentifierType == ItemIdentifierType {
        self.dataSource = AnyDiffableDataSource(dataSource)
    }

    func insert(_ model: ItemIdentifierType, after selectedItem: ItemIdentifierType, in dataSource: DiffableDataSourceType) {
        var snapshot = dataSource.snapshot()
        snapshot.insertItems([model], afterItem: selectedItem)
        dataSource.apply(snapshot)
    }

    func append(_ model: ItemIdentifierType, toSection section: SectionIdentifierType, in dataSource: DiffableDataSourceType) {
        var snapshot = dataSource.snapshot()

        if !snapshot.sectionIdentifiers.contains(section) {
            snapshot.appendSections([section])
        }
        snapshot.appendItems([model], toSection: section)
        dataSource.apply(snapshot)
    }
}

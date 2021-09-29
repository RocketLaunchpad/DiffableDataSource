//
//  TableViewSnapshotStrategy.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/28/21.
//

import UIKit

/// This enables us to demonstrate both "Edit Snapshot" and "Recreate Snapshot" strategies from a single view controller.
protocol SnapshotStrategy {
    associatedtype SectionIdentifierType
    associatedtype ItemIdentifierType

    /// Insert the specified model after the selected model in the specified data source.
    func insert<DiffableDataSourceType>(_ model: ItemIdentifierType,
                                        after selectedItem: ItemIdentifierType,
                                        in dataSource: DiffableDataSourceType)
    where DiffableDataSourceType: DiffableDataSource,
          DiffableDataSourceType.SectionIdentifierType == SectionIdentifierType,
          DiffableDataSourceType.ItemIdentifierType == ItemIdentifierType

    /// Append the specified model at the end of the specified section in the specified data source.
    func append<DiffableDataSourceType>(_ model: ItemIdentifierType,
                                        toSection section: SectionIdentifierType,
                                        in dataSource: DiffableDataSourceType)
    where DiffableDataSourceType: DiffableDataSource,
          DiffableDataSourceType.SectionIdentifierType == SectionIdentifierType,
          DiffableDataSourceType.ItemIdentifierType == ItemIdentifierType
}

extension SnapshotStrategy {

    /**
     Inserts or appends the specified model.

     - If `selectedItem` is not `nil`, the new model is inserted after the selected item in the data source.
     - If `selectedItem` is `nil`, the new model is appended to the end of the specified section.
     */
    func insertOrAppend<DiffableDataSourceType>(_ model: ItemIdentifierType,
                                                after selectedItem: ItemIdentifierType?,
                                                orAtEndOf section: SectionIdentifierType,
                                                in dataSource: DiffableDataSourceType)
    where DiffableDataSourceType: DiffableDataSource,
          DiffableDataSourceType.SectionIdentifierType == SectionIdentifierType,
          DiffableDataSourceType.ItemIdentifierType == ItemIdentifierType
    {

        if let item = selectedItem {
            insert(model, after: item, in: dataSource)
        }
        else {
            append(model, toSection: section, in: dataSource)
        }
    }
}

class AnySnapshotStrategy<SectionIdentifierType, ItemIdentifierType>: SnapshotStrategy
where SectionIdentifierType: Hashable, ItemIdentifierType: Hashable
{
    private let _insert: (ItemIdentifierType, ItemIdentifierType, AnyDiffableDataSource<SectionIdentifierType, ItemIdentifierType>) -> Void

    private let _append: (ItemIdentifierType, SectionIdentifierType, AnyDiffableDataSource<SectionIdentifierType, ItemIdentifierType>) -> Void

    init<T>(_ strategy: T)
    where T: SnapshotStrategy, T.SectionIdentifierType == SectionIdentifierType, T.ItemIdentifierType == ItemIdentifierType
    {
        _insert = { (model, selectedItem, dataSource) in
            strategy.insert(model, after: selectedItem, in: dataSource)
        }

        _append = { (model, section, dataSource) in
            strategy.append(model, toSection: section, in: dataSource)
        }
    }

    func insert<DiffableDataSourceType>(_ model: ItemIdentifierType, after selectedItem: ItemIdentifierType, in dataSource: DiffableDataSourceType)
    where DiffableDataSourceType : DiffableDataSource,
          ItemIdentifierType == DiffableDataSourceType.ItemIdentifierType,
          SectionIdentifierType == DiffableDataSourceType.SectionIdentifierType
    {
        _insert(model, selectedItem, AnyDiffableDataSource(dataSource))
    }

    func append<DiffableDataSourceType>(_ model: ItemIdentifierType, toSection section: SectionIdentifierType, in dataSource: DiffableDataSourceType)
    where DiffableDataSourceType : DiffableDataSource,
          ItemIdentifierType == DiffableDataSourceType.ItemIdentifierType,
          SectionIdentifierType == DiffableDataSourceType.SectionIdentifierType
    {
        _append(model, section, AnyDiffableDataSource(dataSource))
    }
}

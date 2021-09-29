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

    associatedtype DiffableDataSourceType: DiffableDataSource
        where DiffableDataSourceType.SectionIdentifierType == SectionIdentifierType,
              DiffableDataSourceType.ItemIdentifierType == ItemIdentifierType

    var dataSource: DiffableDataSourceType{ get }

    /// Insert the specified model after the selected model in the specified data source.
    func insert(_ model: ItemIdentifierType,
                after selectedItem: ItemIdentifierType,
                in dataSource: DiffableDataSourceType)

    /// Append the specified model at the end of the specified section in the specified data source.
    func append(_ model: ItemIdentifierType,
                toSection section: SectionIdentifierType,
                in dataSource: DiffableDataSourceType)
}

extension SnapshotStrategy {

    /**
     Inserts or appends the specified model.

     - If `selectedItem` is not `nil`, the new model is inserted after the selected item in the data source.
     - If `selectedItem` is `nil`, the new model is appended to the end of the specified section.
     */
    func insertOrAppend(_ model: ItemIdentifierType,
                        after selectedItem: ItemIdentifierType?,
                        orAtEndOf section: SectionIdentifierType,
                        in dataSource: DiffableDataSourceType) {

        if let item = selectedItem {
            insert(model, after: item, in: dataSource)
        }
        else {
            append(model, toSection: section, in: dataSource)
        }
    }
}

class AnySnapshotStrategy<SectionIdentifierType, ItemIdentifierType, DiffableDataSourceType>: SnapshotStrategy
where DiffableDataSourceType: DiffableDataSource,
      DiffableDataSourceType.SectionIdentifierType == SectionIdentifierType,
      DiffableDataSourceType.ItemIdentifierType == ItemIdentifierType
{
    private let _dataSource: () -> DiffableDataSourceType

    private let _insert: ((ItemIdentifierType, ItemIdentifierType, DiffableDataSourceType) -> Void)

    private let _append: ((ItemIdentifierType, SectionIdentifierType, DiffableDataSourceType) -> Void)

    init<T>(_ strategy: T)
    where T: SnapshotStrategy,
          T.SectionIdentifierType == SectionIdentifierType,
          T.ItemIdentifierType == ItemIdentifierType,
          T.DiffableDataSourceType == DiffableDataSourceType
    {
        _dataSource = {
            return strategy.dataSource
        }

        _insert = { (model, selectedItem, dataSource) in
            strategy.insert(model, after: selectedItem, in: dataSource)
        }

        _append = { (model, section, dataSource) in
            strategy.append(model, toSection: section, in: dataSource)
        }
    }

    var dataSource: DiffableDataSourceType {
        return _dataSource()
    }

    func insert(_ model: ItemIdentifierType, after selectedItem: ItemIdentifierType, in dataSource: DiffableDataSourceType) {
        _insert(model, selectedItem, dataSource)
    }

    func append(_ model: ItemIdentifierType, toSection section: SectionIdentifierType, in dataSource: DiffableDataSourceType) {
        _append(model, section, dataSource)
    }
}

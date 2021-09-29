//
//  DiffableDataSource.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/28/21.
//

import UIKit

protocol DiffableDataSource {
    associatedtype SectionIdentifierType: Hashable
    associatedtype ItemIdentifierType: Hashable

    func snapshot() -> NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>
    func apply(_ snapshot: NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>, animatingDifferences: Bool, completion: (() -> Void)?)
}

extension DiffableDataSource {
    func apply(_ snapshot: NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>) {
        apply(snapshot, animatingDifferences: true, completion: nil)
    }
}

extension UITableViewDiffableDataSource: DiffableDataSource { }

extension UICollectionViewDiffableDataSource: DiffableDataSource { }

struct AnyDiffableDataSource<SectionIdentifierType, ItemIdentifierType>: DiffableDataSource
where SectionIdentifierType: Hashable, ItemIdentifierType: Hashable {

    private let _snapshot: () -> NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>

    private let _apply: (NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>, Bool, (() -> Void)?) -> Void

    init<T>(_ dataSource: T)
    where T: DiffableDataSource, T.SectionIdentifierType == SectionIdentifierType, T.ItemIdentifierType == ItemIdentifierType {
        _snapshot = {
            dataSource.snapshot()
        }

        _apply = { (snapshot, animatingDifferences, completion) in
            dataSource.apply(snapshot, animatingDifferences: animatingDifferences, completion: completion)
        }
    }

    func snapshot() -> NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType> {
        return _snapshot()
    }

    func apply(_ snapshot: NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>, animatingDifferences: Bool, completion: (() -> Void)?) {
        _apply(snapshot, animatingDifferences, completion)
    }
}

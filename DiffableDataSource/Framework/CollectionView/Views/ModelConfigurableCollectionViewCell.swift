//
//  ModelConfigurableCollectionViewCell.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/28/21.
//

import UIKit

/**
 Represents a collection view cell that can configure itself with a specific model type.

 Cell types should be registered with the `UICollectionView` via the `register(cellType:)` function.
 */
protocol ModelConfigurableCollectionViewCell {

    /// The type of model that the cell requires. Since `ModelType.CellType` is constrained to be a `UICollectionViewCell` subclass, this effectively constrains `Self` to be a `UICollectionViewCell` subclass as well. In fact, if we were to add `UITableViewCell` as a superclass constraint on this protocol, the compiler emits a "redundant superclass constraint" warning.
    associatedtype ModelType: CollectionViewCellModel where ModelType.CollectionViewCellType == Self

    /// Configure this cell with the specified model. The implementation should populate the cell's UI controls with data from the model.
    func configure(with model: ModelType)
}

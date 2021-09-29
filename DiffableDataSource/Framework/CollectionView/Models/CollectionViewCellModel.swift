//
//  CollectionViewCellModel.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/28/21.
//

import UIKit

/// Represents a model that corresponds to a particular cell type.
protocol CollectionViewCellModel {

    /// The type of the cell that this model corresponds to.
    associatedtype CollectionViewCellType: UICollectionViewCell

    func dequeueAndConfigureCell(in collectionView: UICollectionView, for indexPath: IndexPath) -> CollectionViewCellType
}

/// This allows us to automatically configure the cell without having to write boilerplate code in the model. By default, implementations of `CollectionViewCellModel` need only have a typealias defining their `CellType` to be the required `UICollectionViewCell` subtype.
extension CollectionViewCellModel where CollectionViewCellType: ModelConfigurableCollectionViewCell, CollectionViewCellType.ModelType == Self {
 
    func dequeueAndConfigureCell(in collectionView: UICollectionView, for indexPath: IndexPath) -> CollectionViewCellType {
        return collectionView.dequeueCell(for: indexPath, andConfigureWith: self)
    }
}

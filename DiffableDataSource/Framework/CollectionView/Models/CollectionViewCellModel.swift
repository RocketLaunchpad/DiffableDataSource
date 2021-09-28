//
//  CollectionViewCellModel.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/28/21.
//

import UIKit

protocol CollectionViewCellModel {

    associatedtype CollectionViewCellType: UICollectionViewCell

    func dequeueAndConfigureCell(in collectionView: UICollectionView, for indexPath: IndexPath) -> CollectionViewCellType
}

extension CollectionViewCellModel where CollectionViewCellType: ModelConfigurableCollectionViewCell, CollectionViewCellType.ModelType == Self {
 
    func dequeueAndConfigureCell(in collectionView: UICollectionView, for indexPath: IndexPath) -> CollectionViewCellType {
        return collectionView.dequeueCell(for: indexPath, andConfigureWith: self)
    }
}

//
//  UICollectionView+ModelConfigurable.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/28/21.
//

import UIKit
import UIKitExtensions

extension UICollectionView {

    /// Uses generics to simplify dequeueing and configuring cells.
    func dequeueCell<CellType, ModelType>(for indexPath: IndexPath, andConfigureWith model: ModelType) -> CellType
    where CellType: ModelConfigurableCollectionViewCell, CellType.ModelType == ModelType
    {
        // This uses a UIKitExtensions function: `UICollectionView.dequeueReusableCell(for:)`, which uses the default `reuseIdentifier` for the cell type.
        let cell: CellType = dequeueReusableCell(for: indexPath)
        cell.configure(with: model)
        return cell
    }

    /// Registers the specified `ModelConfigurableCollectionViewCell` type with the table view. The default `reuseIdentifier` specified for the cell type by `UIKitExtensions` is used.
    func register<CellType>(cellType: CellType.Type) where CellType: ModelConfigurableCollectionViewCell {
        register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
}

//
//  UICollectionView+ModelConfigurable.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/28/21.
//

import UIKit
import UIKitExtensions

extension UICollectionView {

    func dequeueCell<CellType, ModelType>(for indexPath: IndexPath, andConfigureWith model: ModelType) -> CellType
    where CellType: ModelConfigurableCollectionViewCell, CellType.ModelType == ModelType
    {
        let cell: CellType = dequeueReusableCell(for: indexPath)
        cell.configure(with: model)
        return cell
    }

    func register<CellType>(cellType: CellType.Type) where CellType: ModelConfigurableCollectionViewCell {
        register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
}

//
//  UITableView+ModelConfigurable.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/24/21.
//

import UIKit
import UIKitExtensions

extension UITableView {

    private func dequeueReusableModelConfigurableCell<T: ModelConfigurableCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not cast reusable cell with reuse identifier \"\(T.reuseIdentifier)\" to the expected type")
        }
        return cell
    }

    func dequeueConfiguredCell<CellType, ModelType>(for indexPath: IndexPath, with model: ModelType) -> CellType
        where CellType: ModelConfigurableCell, CellType.ModelType == ModelType
    {
        let cell: CellType = dequeueReusableCell(for: indexPath)
        cell.configure(with: model)
        return cell
    }

    func register<CellType>(cellType: CellType.Type) where CellType: ModelConfigurableCell {
        register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
}

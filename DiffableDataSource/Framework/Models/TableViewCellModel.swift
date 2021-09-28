//
//  TableViewCellModel.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/24/21.
//

import UIKit

/// Represents a model that corresponds to a particular cell type.
protocol TableViewCellModel {

    /// The type of the cell that this model corresponds to.
    associatedtype CellType: UITableViewCell

    func dequeueAndConfigureCell(in tableView: UITableView, for indexPath: IndexPath) -> CellType
}

/// This allows us to automatically configure the cell without having to write boilerplate code in the model. By default, implementations of `TableViewCellModel` need only have a typealias defining their `CellType` to be the required `UITableViewCell` subtype.
extension TableViewCellModel where CellType: ModelConfigurableTableViewCell, CellType.ModelType == Self {

    func dequeueAndConfigureCell(in tableView: UITableView, for indexPath: IndexPath) -> CellType {
        return tableView.dequeueCell(for: indexPath, andConfigureWith: self)
    }
}

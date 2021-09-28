//
//  ModelConfigurableTableViewCell.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/24/21.
//

import UIKit

/// Represents a table view cell that can configure itself with a specific model type.
protocol ModelConfigurableTableViewCell: UITableViewCell {

    /// The type of model that the cell requires.
    associatedtype ModelType

    /// Configure this cell with the specified model.
    func configure(with model: ModelType)
}

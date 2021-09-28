//
//  ModelConfigurableCell.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/24/21.
//

import UIKit

protocol ModelConfigurableCell: UITableViewCell {
    associatedtype ModelType
    func configure(with model: ModelType)
}

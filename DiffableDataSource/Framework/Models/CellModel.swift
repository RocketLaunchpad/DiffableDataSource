//
//  CellModel.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/24/21.
//

import UIKit

protocol CellModel {
    func configureCell(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
}

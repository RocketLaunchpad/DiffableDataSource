//
//  AnyCellModel.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/24/21.
//

import UIKit

struct AnyCellModel: CellModel, Hashable {

    private let _configureCell: (UITableView, IndexPath) -> UITableViewCell

    private let _cryptoHash: () -> CryptoDigest

    private let _hashInto: (inout Hasher) -> Void

    init<ModelType>(_ model: ModelType) where ModelType: CellModel & Hashable & CryptoHashable {
        _configureCell = { (tableView, indexPath) -> UITableViewCell in
            model.configureCell(in: tableView, at: indexPath)
        }

        _cryptoHash = {
            model.cryptoHash
        }

        _hashInto = { (hasher: inout Hasher) in
            model.hash(into: &hasher)
        }
    }

    func configureCell(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        return _configureCell(tableView, indexPath)
    }

    func hash(into hasher: inout Hasher) {
        _hashInto(&hasher)
    }

    static func == (lhs: AnyCellModel, rhs: AnyCellModel) -> Bool {
        return lhs._cryptoHash() == rhs._cryptoHash()
    }
}

//
//  TextModel.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/24/21.
//

import UIKit

struct TextModel: CellModel, Hashable, CryptoHashable {

    static let loremIpsum = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore \
        magna aliqua.
        """

    var title: String

    var body: String

    func configureCell(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueConfiguredCell(for: indexPath, with: self) as TextCell
    }

    static func model(forIndex index: Int) -> TextModel {
        return TextModel(title: "Text \(index + 1)", body: loremIpsum)
    }
}

//
//  ImageModel.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/24/21.
//

import UIKit

struct ImageModel: TableViewCellModel, Hashable, CryptoHashable {

    var title: String

    var imageSystemName: String

    func configureCell(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueConfiguredCell(for: indexPath, with: self) as ImageCell
    }
}

extension ImageModel {

    static let defaultImageNames = [
        "folder.fill",
        "tray.fill",
        "archivebox.fill",
        "doc.text.fill"
    ]

    static func model(forIndex index: Int) -> ImageModel {
        return ImageModel(title: "Image \(index + 1)", imageSystemName: defaultImageNames[index % defaultImageNames.count])
    }
}

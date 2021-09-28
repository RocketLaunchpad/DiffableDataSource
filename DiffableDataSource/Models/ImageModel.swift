//
//  ImageModel.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/24/21.
//

import UIKit

struct ImageModel: TableViewCellModel, Hashable, CryptoHashable {

    typealias CellType = ImageCell

    var title: String

    var imageSystemName: String
}

extension ImageModel {

    var image: UIImage? {
        return UIImage(systemName: imageSystemName)
    }
}

// MARK: - Placeholder model creation

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

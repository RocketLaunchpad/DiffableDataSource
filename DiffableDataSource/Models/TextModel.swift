//
//  TextModel.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/24/21.
//

import UIKit

struct TextModel: TableViewCellModel, CollectionViewCellModel, Hashable, CryptoHashable {

    typealias TableViewCellType = TextTableViewCell

    typealias CollectionViewCellType = TextCollectionViewCell

    var title: String

    var body: String
}

// MARK: - Placeholder model creation

extension TextModel {

    static let loremIpsum = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore \
        magna aliqua.
        """

    static func model(forIndex index: Int) -> TextModel {
        return TextModel(title: "Text \(index + 1)", body: loremIpsum)
    }
}

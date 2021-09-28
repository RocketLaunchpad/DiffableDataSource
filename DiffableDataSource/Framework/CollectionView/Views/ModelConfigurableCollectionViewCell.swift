//
//  ModelConfigurableCollectionViewCell.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/28/21.
//

import UIKit

protocol ModelConfigurableCollectionViewCell {

    associatedtype ModelType: CollectionViewCellModel where ModelType.CollectionViewCellType == Self

    func configure(with model: ModelType)
}

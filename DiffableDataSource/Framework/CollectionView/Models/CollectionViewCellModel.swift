//
//  CollectionViewCellModel.swift
//  DiffableDataSource
//
//  Copyright (c) 2021 Rocket Insights, Inc.
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
//  DEALINGS IN THE SOFTWARE.
//

import UIKit

/// Represents a model that corresponds to a particular cell type.
protocol CollectionViewCellModel {

    /// The type of the cell that this model corresponds to.
    associatedtype CollectionViewCellType: UICollectionViewCell

    func dequeueAndConfigureCell(in collectionView: UICollectionView, for indexPath: IndexPath) -> CollectionViewCellType
}

/// This allows us to automatically configure the cell without having to write boilerplate code in the model. By default, implementations of `CollectionViewCellModel` need only have a typealias defining their `CellType` to be the required `UICollectionViewCell` subtype.
extension CollectionViewCellModel where CollectionViewCellType: ModelConfigurableCollectionViewCell, CollectionViewCellType.ModelType == Self {
 
    func dequeueAndConfigureCell(in collectionView: UICollectionView, for indexPath: IndexPath) -> CollectionViewCellType {
        return collectionView.dequeueCell(for: indexPath, andConfigureWith: self)
    }
}

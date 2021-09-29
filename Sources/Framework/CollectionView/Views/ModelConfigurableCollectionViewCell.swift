//
//  ModelConfigurableCollectionViewCell.swift
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

/**
 Represents a collection view cell that can configure itself with a specific model type.

 Cell types should be registered with the `UICollectionView` via the `register(cellType:)` function.
 */
protocol ModelConfigurableCollectionViewCell {

    /// The type of model that the cell requires. Since `ModelType.CellType` is constrained to be a `UICollectionViewCell` subclass, this effectively constrains `Self` to be a `UICollectionViewCell` subclass as well. In fact, if we were to add `UITableViewCell` as a superclass constraint on this protocol, the compiler emits a "redundant superclass constraint" warning.
    associatedtype ModelType: CollectionViewCellModel where ModelType.CollectionViewCellType == Self

    /// Configure this cell with the specified model. The implementation should populate the cell's UI controls with data from the model.
    func configure(with model: ModelType)
}

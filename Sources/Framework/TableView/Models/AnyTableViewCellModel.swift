//
//  AnyTableViewCellModel.swift
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
 Applies a type-erasure pattern to allow a heterogeneous collection of `TableViewCellModel` instances. This is intended for use as the item identifier in a `UITableViewDiffableDataSource`, but it can also be used to maintain any other heterogeneous collection of `TableViewCellModel` instances.

 To be used with `UITableViewDiffableDataSource`, we need to implement `Hashable` and `Equatable`. We can implement `Hashable` using a closure to invoke `hash(into:)` on the model value passed to the initializer. We cannot implement `Equatable` using this same approach. Since we are type-erased, we do not have enough information to implement `Equatable`. To get around this limitation, we use the `CryptoHashable` protocol defined in this project. This returns a cryptographic hash of the contents of the model. We use this hash to test for equality.
 */
struct AnyTableViewCellModel: TableViewCellModel, Hashable {

    private let _dequeueAndConfigureCell: (UITableView, IndexPath) -> UITableViewCell

    private let _cryptoHash: () -> CryptoDigest

    private let _hashInto: (inout Hasher) -> Void

    /// Creates a type erased `TableViewCellModel` instance that is also `Hashable`. The model must also implement `CryptoHashable` to allow us to use the cryptographic hash to test for equality.
    init<ModelType>(_ model: ModelType) where ModelType: TableViewCellModel & Hashable & CryptoHashable {
        _dequeueAndConfigureCell = { (tableView, indexPath) -> UITableViewCell in
            model.dequeueAndConfigureCell(in: tableView, for: indexPath)
        }

        _cryptoHash = {
            model.cryptoHash
        }

        _hashInto = { (hasher: inout Hasher) in
            model.hash(into: &hasher)
        }
    }

    func dequeueAndConfigureCell(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        return _dequeueAndConfigureCell(tableView, indexPath)
    }

    func hash(into hasher: inout Hasher) {
        _hashInto(&hasher)
    }

    static func == (lhs: AnyTableViewCellModel, rhs: AnyTableViewCellModel) -> Bool {
        return lhs._cryptoHash() == rhs._cryptoHash()
    }
}

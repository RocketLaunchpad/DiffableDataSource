//
//  UITableView+ModelConfigurable.swift
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
import UIKitExtensions

extension UITableView {

    /// Uses generics to simplify dequeueing and configuring cells.
    func dequeueCell<CellType, ModelType>(for indexPath: IndexPath, andConfigureWith model: ModelType) -> CellType
    where CellType: ModelConfigurableTableViewCell, CellType.ModelType == ModelType
    {
        // This uses a UIKitExtensions function: `UITableView.dequeueReusableCell(for:)`, which uses the default `reuseIdentifier` for the cell type.
        let cell: CellType = dequeueReusableCell(for: indexPath)
        cell.configure(with: model)
        return cell
    }

    /// Registers the specified `ModelConfigurableTableViewCell` type with the table view. The default `reuseIdentifier` specified for the cell type by `UIKitExtensions` is used.
    func register<CellType>(cellType: CellType.Type) where CellType: ModelConfigurableTableViewCell {
        register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
}

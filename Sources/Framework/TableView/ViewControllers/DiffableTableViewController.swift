//
//  DiffableTableViewController.swift
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
 Base implementation of a table view controller that uses a diffable data source.

 This allows heterogeneous cell models via the `AnyTableViewCellModel` type-erasure. These models are used as item identifiers in the underlying diffable data source.

 The `SectionModel` parameterized-type is the section identifier type specified by subclasses.
 */
class DiffableTableViewController<SectionModel>: UIViewController where SectionModel: Hashable {

    /// The diffable data source type for this type. This is simply an abbreviation to simplify other declarations.
    typealias DiffableDataSourceType = UITableViewDiffableDataSource<SectionModel, AnyTableViewCellModel>

    private(set) var tableView: UITableView!

    /// The table view style. Subclasses can modify this before calling `super.viewDidLoad()`. Modifying this value after calling `super.viewDidLoad()` will have no effect.
    var style: UITableView.Style = .plain

    private(set) var dataSource: DiffableDataSourceType!

    override func viewDidLoad() {
        super.viewDidLoad()

        createTableView()
        createDataSource()
    }

    private func createTableView() {
        tableView = UITableView(frame: view.bounds, style: style)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(tableView)
    }

    private func createDataSource() {
        // The cell provider uses the model to dequeue and configure the cell.
        dataSource = DiffableDataSourceType(tableView: tableView) { (tableView, indexPath, model) -> UITableViewCell in
            model.dequeueAndConfigureCell(in: tableView, for: indexPath)
        }
    }
}

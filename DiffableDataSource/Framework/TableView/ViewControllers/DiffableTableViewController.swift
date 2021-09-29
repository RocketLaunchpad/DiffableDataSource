//
//  DiffableTableViewController.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/24/21.
//

import UIKit

/// Base implementation of a table view controller that uses a diffable data source.
///
/// This allows heterogeneous cell models via the `AnyTableViewCellModel` type-erasure. These models are used as item identifiers in the underlying diffable data source.
///
/// The `SectionModel` parameterized-type is the section identifier type specified by subclasses.
///
class DiffableTableViewController<SectionModel>: UIViewController where SectionModel: Hashable {

    /// The diffable data source type for this type. This is simply an abbreviation to simplify other declarations.
    typealias DataSourceType = UITableViewDiffableDataSource<SectionModel, AnyTableViewCellModel>

    /// The snapshot type for this type. This is simply an abbreviation to simplify other declarations.
    typealias SnapshotType = NSDiffableDataSourceSnapshot<SectionModel, AnyTableViewCellModel>

    private(set) var tableView: UITableView!

    /// The table view style. Subclasses can modify this before calling `super.viewDidLoad()`. Modifying this value after calling `super.viewDidLoad()` will have no effect.
    var style: UITableView.Style = .plain

    private(set) var dataSource: DataSourceType!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        loadViewIfNeeded()
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
        dataSource = DataSourceType(tableView: tableView) { (tableView, indexPath, model) -> UITableViewCell in
            model.dequeueAndConfigureCell(in: tableView, for: indexPath)
        }
    }
}

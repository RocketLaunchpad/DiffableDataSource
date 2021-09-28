//
//  DiffableTableViewController.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/24/21.
//

import UIKit

class DiffableTableViewController<SectionModel>: UIViewController where SectionModel: Hashable {

    typealias DataSourceType = UITableViewDiffableDataSource<SectionModel, AnyCellModel>

    private(set) var tableView: UITableView!

    var style: UITableView.Style = .plain

    var dataSource: DataSourceType!

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
        let provider: DataSourceType.CellProvider = { (tableView, indexPath, model) -> UITableViewCell in
            model.configureCell(in: tableView, at: indexPath)
        }
        dataSource = DataSourceType(tableView: tableView, cellProvider: provider)
    }
}

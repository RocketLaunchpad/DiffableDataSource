//
//  DefaultTableViewController.swift
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

import Then
import UIKit

/// Default section indices.
enum DefaultTableViewControllerSection: Int, CaseIterable {
    case defaultImageSection
    case defaultTextSection
}

/**
 An example of a diffable table view controller.

 When the user taps the "+" button, an action sheet is presented allowing the user to pick which cell type to add: an image, or text. Once the user chooses, a new cell is added to the table view. If a cell was selected prior to tapping "+", the new cell is inserted after the selected cell. Otherwise, the cell is added to the default section corresponding to the user's choice.

 Snapshot operations are abstracted behind the `SnapshotStrategy` protocol. The `strategy` property must be set. Note that a strong reference to the `strategy` property is retained.
 */
class DefaultTableViewController: DiffableTableViewController<DefaultTableViewControllerSection> {

    private var imageCounter = 0

    private var textCounter = 0

    override func viewDidLoad() {
        super.style = .insetGrouped
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addButtonTapped(_:)))

        tableView.register(cellType: TextTableViewCell.self)
        tableView.register(cellType: ImageTableViewCell.self)

        tableView.backgroundView = UILabel(frame: tableView.bounds).then {
            $0.text = "Tap the + button to add an item"
            $0.textAlignment = .center
            $0.textColor = .systemGray
        }
    }

    /// Show the action sheet and perform the selected action.
    @objc private func addButtonTapped(_ sender: Any) {
        let selectedItem = tableView.indexPathForSelectedRow.flatMap {
            dataSource?.itemIdentifier(for: $0)
        }

        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Image", style: .default, handler: { [weak self] _ in
            self?.addImage(after: selectedItem)
        }))
        actionSheet.addAction(UIAlertAction(title: "Text", style: .default, handler: { [weak self] _ in
            self?.addText(after: selectedItem)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(actionSheet, animated: true)
    }

    private func addImage(after selectedItem: AnyTableViewCellModel?) {
        let model = AnyTableViewCellModel(ImageModel.model(forIndex: imageCounter))
        imageCounter += 1
        insertOrAppend(model, after: selectedItem, orAtEndOf: .defaultImageSection)

        itemAdded()
    }

    private func addText(after selectedItem: AnyTableViewCellModel?) {
        let model = AnyTableViewCellModel(TextModel.model(forIndex: textCounter))
        textCounter += 1
        insertOrAppend(model, after: selectedItem, orAtEndOf: .defaultTextSection)

        itemAdded()
    }

    private func insertOrAppend(_ model: AnyTableViewCellModel,
                                after selectedItem: AnyTableViewCellModel?,
                                orAtEndOf section: DefaultTableViewControllerSection) {

        if let item = selectedItem {
            insert(model, after: item)
        }
        else {
            append(model, toSection: section)
        }
    }

    private func insert(_ model: AnyTableViewCellModel, after selectedItem: AnyTableViewCellModel) {
        var snapshot = dataSource.snapshot()
        snapshot.insertItems([model], afterItem: selectedItem)
        dataSource.apply(snapshot)
    }

    private func append(_ model: AnyTableViewCellModel, toSection section: DefaultTableViewControllerSection) {
        var snapshot = dataSource.snapshot()

        if !snapshot.sectionIdentifiers.contains(section) {
            snapshot.appendSections([section])
        }
        snapshot.appendItems([model], toSection: section)
        dataSource.apply(snapshot)
    }

    private func itemAdded() {
        tableView.backgroundView = nil
        tableView.indexPathForSelectedRow.map {
            tableView.deselectRow(at: $0, animated: true)
        }
    }
}

//
//  DefaultTableViewController.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/24/21.
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

    var strategy: SnapshotStrategy!

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
        strategy.insertOrAppend(model, after: selectedItem, orAtEndOf: .defaultImageSection, in: dataSource)

        itemAdded()
    }

    private func addText(after selectedItem: AnyTableViewCellModel?) {
        let model = AnyTableViewCellModel(TextModel.model(forIndex: textCounter))
        textCounter += 1
        strategy.insertOrAppend(model, after: selectedItem, orAtEndOf: .defaultTextSection, in: dataSource)

        itemAdded()
    }

    private func itemAdded() {
        tableView.backgroundView = nil
        tableView.indexPathForSelectedRow.map {
            tableView.deselectRow(at: $0, animated: true)
        }
    }
}

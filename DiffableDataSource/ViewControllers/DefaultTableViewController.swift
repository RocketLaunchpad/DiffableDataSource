//
//  DefaultTableViewController.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/24/21.
//

import UIKit

enum DefaultTableViewControllerSection: Int, CaseIterable {
    case defaultImageSection
    case defaultTextSection
}

class DefaultTableViewController: DiffableTableViewController<DefaultTableViewControllerSection> {

    private var imageCounter = 0

    private var labelCounter = 0

    var strategy: SnapshotStrategy?

    override func viewDidLoad() {
        super.style = .insetGrouped
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addButtonTapped(_:)))

        tableView.register(cellType: TextCell.self)
        tableView.register(cellType: ImageCell.self)

        tableView.backgroundView = UILabel(frame: tableView.bounds).then {
            $0.text = "Tap the + button to add an item"
            $0.textAlignment = .center
            $0.textColor = .systemGray
        }
    }

    @objc
    private func addButtonTapped(_ sender: Any) {
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
        strategy?.insertOrAppend(model, after: selectedItem, orAtEndOf: .defaultImageSection, in: dataSource)

        itemAdded()
    }

    private func addText(after selectedItem: AnyTableViewCellModel?) {
        let model = AnyTableViewCellModel(TextModel.model(forIndex: labelCounter))
        labelCounter += 1
        strategy?.insertOrAppend(model, after: selectedItem, orAtEndOf: .defaultTextSection, in: dataSource)

        itemAdded()
    }

    private func itemAdded() {
        tableView.backgroundView = nil

        tableView.indexPathForSelectedRow.map {
            tableView.deselectRow(at: $0, animated: true)
        }
    }
}

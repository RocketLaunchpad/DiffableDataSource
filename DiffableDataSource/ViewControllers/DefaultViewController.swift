//
//  DefaultViewController.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/24/21.
//

import UIKit

enum DefaultViewControllerSection: Int {
    case defaultImageSection
    case defaultTextSection
}

protocol DefaultViewControllerDelegate: AnyObject {
    func defaultViewController(_ sender: DefaultViewController,
                               insertOrAppend model: AnyCellModel,
                               after selection: AnyCellModel?,
                               orAtEndOf section: DefaultViewControllerSection)
}

class DefaultViewController: DiffableTableViewController<DefaultViewControllerSection> {

    private var imageCounter = 0

    private var labelCounter = 0

    weak var delegate: DefaultViewControllerDelegate?

    override func viewDidLoad() {
        super.style = .insetGrouped
        super.viewDidLoad()

        title = "Diffable Data Source"

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addButtonTapped(_:)))

        tableView.register(cellType: TextCell.self)
        tableView.register(cellType: ImageCell.self)
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

    private func addImage(after selectedItem: AnyCellModel?) {
        let model = ImageModel.model(forIndex: imageCounter)
        imageCounter += 1
        delegate?.defaultViewController(self, insertOrAppend: AnyCellModel(model), after: selectedItem, orAtEndOf: .defaultImageSection)
        clearSelection()
    }

    private func addText(after selectedItem: AnyCellModel?) {
        let model = TextModel.model(forIndex: labelCounter)
        labelCounter += 1
        delegate?.defaultViewController(self, insertOrAppend: AnyCellModel(model), after: selectedItem, orAtEndOf: .defaultTextSection)
        clearSelection()
    }

    private func clearSelection() {
        tableView.indexPathForSelectedRow.map {
            tableView.deselectRow(at: $0, animated: true)
        }
    }
}

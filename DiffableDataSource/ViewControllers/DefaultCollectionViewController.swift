//
//  DefaultCollectionViewController.swift
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

enum DefaultCollectionViewControllerSection: Int, CaseIterable {
    case defaultImageSection
    case defaultTextSection
}

class DefaultCollectionViewController: DiffableCollectionViewController<DefaultCollectionViewControllerSection> {

    private var imageCounter = 0

    private var textCounter = 0

    override func viewDidLoad() {
        layout = UICollectionViewCompositionalLayout { (sectionIndex, _) in
            guard let section = DefaultCollectionViewControllerSection(rawValue: sectionIndex) else {
                fatalError("Unknown section index: \(sectionIndex)")
            }

            switch section {
            case .defaultTextSection:
                return Self.createTextSectionLayout()

            case .defaultImageSection:
                return Self.createImageSectionLayout()
            }
        }
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addButtonTapped(_:)))

        collectionView.register(cellType: TextCollectionViewCell.self)
        collectionView.register(cellType: ImageCollectionViewCell.self)

        collectionView.backgroundView = UILabel(frame: collectionView.bounds).then {
            $0.text = "Tap the + button to add an item"
            $0.textAlignment = .center
            $0.textColor = .systemGray
        }
        collectionView.allowsSelection = false
    }

    @objc private func addButtonTapped(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Image", style: .default, handler: { [weak self] _ in
            self?.addImage()
        }))
        actionSheet.addAction(UIAlertAction(title: "Text", style: .default, handler: { [weak self] _ in
            self?.addText()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(actionSheet, animated: true)
    }

    private func addImage() {
        let model = AnyCollectionViewCellModel(ImageModel.model(forIndex: imageCounter))
        imageCounter += 1

        append(model, toSection: .defaultImageSection)
        itemAdded()
    }

    private func addText() {
        let model = AnyCollectionViewCellModel(TextModel.model(forIndex: textCounter))
        textCounter += 1

        append(model, toSection: .defaultTextSection)
        itemAdded()
    }

    private func append(_ model: AnyCollectionViewCellModel, toSection section: DefaultCollectionViewControllerSection) {
        var snapshot = dataSource.snapshot()

        if !snapshot.sectionIdentifiers.contains(section) {
            snapshot.appendSections([section])
        }
        snapshot.appendItems([model], toSection: section)
        dataSource.apply(snapshot)
    }

    private func itemAdded() {
        collectionView.backgroundView = nil
    }
}

// MARK: - Layouts

extension DefaultCollectionViewController {

    // https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views

    private static func createTextSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(64))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(64))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item])
        return NSCollectionLayoutSection(group: group)
    }

    private static func createImageSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        return NSCollectionLayoutSection(group: group)
    }
}

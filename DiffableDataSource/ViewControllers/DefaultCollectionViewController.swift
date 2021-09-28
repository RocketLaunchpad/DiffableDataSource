//
//  DefaultCollectionViewController.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/28/21.
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

        itemAdded()
    }

    private func addText() {
        let model = AnyCollectionViewCellModel(TextModel.model(forIndex: textCounter))
        textCounter += 1

        itemAdded()
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

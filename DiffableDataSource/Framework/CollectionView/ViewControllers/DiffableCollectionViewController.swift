//
//  DiffableCollectionViewController.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/28/21.
//

import UIKit

class DiffableCollectionViewController<SectionModel>: UIViewController where SectionModel: Hashable {

    typealias DiffableDataSourceType = UICollectionViewDiffableDataSource<SectionModel, AnyCollectionViewCellModel>

    private(set) var collectionView: UICollectionView!

    private(set) var dataSource: DiffableDataSourceType!

    var layout: UICollectionViewLayout!

    override func viewDidLoad() {
        super.viewDidLoad()

        createCollectionView()
        createDataSource()
    }

    private func createCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
    }

    private func createDataSource() {
        dataSource = DiffableDataSourceType(collectionView: collectionView) { (collectionView, indexPath, model) -> UICollectionViewCell in
            model.dequeueAndConfigureCell(in: collectionView, for: indexPath)
        }
    }
}

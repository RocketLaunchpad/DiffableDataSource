//
//  DiffableCollectionViewController.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/28/21.
//

import UIKit

class DiffableCollectionViewController<SectionModel>: UIViewController where SectionModel: Hashable {

    typealias DataSourceType = UICollectionViewDiffableDataSource<SectionModel, AnyCollectionViewCellModel>

    typealias SnapshotType = NSDiffableDataSourceSnapshot<SectionModel, AnyCollectionViewCellModel>

    private(set) var collectionView: UICollectionView!

    private(set) var dataSource: DataSourceType!

    var layout: UICollectionViewLayout!

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
        createCollectionView()
        createDataSource()
    }

    private func createCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
    }

    private func createDataSource() {
        dataSource = DataSourceType(collectionView: collectionView) { (collectionView, indexPath, model) -> UICollectionViewCell in
            model.dequeueAndConfigureCell(in: collectionView, for: indexPath)
        }
    }
}

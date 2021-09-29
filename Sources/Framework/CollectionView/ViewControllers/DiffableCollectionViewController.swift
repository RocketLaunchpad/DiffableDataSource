//
//  DiffableCollectionViewController.swift
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

import UIKit

/**
 Base implementation of a collection view controller that uses a diffable data source.

 This allows heterogeneous cell models via the `AnyCollectionViewCellModel` type-erasure. These models are used as item identifiers in the underlying diffable data source.

 The `SectionModel` parameterized-type is the section identifier type specified by subclasses.
 */
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

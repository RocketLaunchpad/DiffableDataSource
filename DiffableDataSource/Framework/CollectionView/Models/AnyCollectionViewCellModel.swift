//
//  AnyCollectionViewCellModel.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/28/21.
//

import UIKit

struct AnyCollectionViewCellModel: CollectionViewCellModel, Hashable {

    private let _dequeueAndConfigureCell: (UICollectionView, IndexPath) -> UICollectionViewCell

    private let _cryptoHash: () -> CryptoDigest

    private let _hashInto: (inout Hasher) -> Void

    init<ModelType>(_ model: ModelType) where ModelType: CollectionViewCellModel & Hashable & CryptoHashable {
        _dequeueAndConfigureCell = { (collectionView, indexPath) -> UICollectionViewCell in
            model.dequeueAndConfigureCell(in: collectionView, for: indexPath)
        }

        _cryptoHash = {
            model.cryptoHash
        }

        _hashInto = { (hasher: inout Hasher) in
            model.hash(into: &hasher)
        }
    }

    func dequeueAndConfigureCell(in collectionView: UICollectionView, for indexPath: IndexPath) -> some UICollectionViewCell {
        return _dequeueAndConfigureCell(collectionView, indexPath)
    }

    func hash(into hasher: inout Hasher) {
        _hashInto(&hasher)
    }

    static func == (lhs: AnyCollectionViewCellModel, rhs: AnyCollectionViewCellModel) -> Bool {
        return lhs._cryptoHash() == rhs._cryptoHash()
    }
}

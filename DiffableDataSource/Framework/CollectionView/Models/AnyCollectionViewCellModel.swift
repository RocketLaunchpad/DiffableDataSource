//
//  AnyCollectionViewCellModel.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/28/21.
//

import UIKit

/**
 Applies a type-erasure pattern to allow a heterogeneous collection of `CollectionViewCellModel` instances. This is intended for use as the item identifier in a `UICollectionViewDiffableDataSource`, but it can also be used to maintain any other heterogeneous collection of `CollectionViewCellModel` instances.

 To be used with `UICollectionViewDiffableDataSource`, we need to implement `Hashable` and `Equatable`. We can implement `Hashable` using a closure to invoke `hash(into:)` on the model value passed to the initializer. We cannot implement `Equatable` using this same approach. Since we are type-erased, we do not have enough information to implement `Equatable`. To get around this limitation, we use the `CryptoHashable` protocol defined in this project. This returns a cryptographic hash of the contents of the model. We use this hash to test for equality.
 */
struct AnyCollectionViewCellModel: CollectionViewCellModel, Hashable {

    private let _dequeueAndConfigureCell: (UICollectionView, IndexPath) -> UICollectionViewCell

    private let _cryptoHash: () -> CryptoDigest

    private let _hashInto: (inout Hasher) -> Void

    /// Creates a type erased `CollectionViewCellModel` instance that is also `Hashable`. The model must also implement `CryptoHashable` to allow us to use the cryptographic hash to test for equality.
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

    func dequeueAndConfigureCell(in collectionView: UICollectionView, for indexPath: IndexPath) -> UICollectionViewCell {
        return _dequeueAndConfigureCell(collectionView, indexPath)
    }

    func hash(into hasher: inout Hasher) {
        _hashInto(&hasher)
    }

    static func == (lhs: AnyCollectionViewCellModel, rhs: AnyCollectionViewCellModel) -> Bool {
        return lhs._cryptoHash() == rhs._cryptoHash()
    }
}

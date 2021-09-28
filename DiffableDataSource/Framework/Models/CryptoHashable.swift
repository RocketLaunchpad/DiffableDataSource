//
//  CryptoHashable.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/24/21.
//

import CryptoKit
import Foundation

typealias CryptoAlgorithm = SHA512
typealias CryptoDigest = SHA512Digest

protocol CryptoHashable {
    var cryptoHash: CryptoDigest { get }
}

extension CryptoHashable {
    var cryptoHash: CryptoDigest {
        return withUnsafeBytes(of: self) {
            var hasher = CryptoAlgorithm()
            hasher.update(bufferPointer: $0)
            return hasher.finalize()
        }
    }
}

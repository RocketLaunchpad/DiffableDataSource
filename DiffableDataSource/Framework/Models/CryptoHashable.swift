//
//  CryptoHashable.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/24/21.
//

import CryptoKit
import Foundation

// Typealiases allowing us to substitute a different hashing algorithm and corresponding digest type.
typealias CryptoAlgorithm = SHA512
typealias CryptoDigest = SHA512Digest

protocol CryptoHashable {
    var cryptoHash: CryptoDigest { get }
}

extension CryptoHashable {
    var cryptoHash: CryptoDigest {
        
        // Compute the cryptographic hash of the raw bytes of `self`. This will test equality of value types. This will only test for pointer equality for reference types.
        return withUnsafeBytes(of: self) {
            var hasher = CryptoAlgorithm()
            hasher.update(bufferPointer: $0)
            return hasher.finalize()
        }
    }
}

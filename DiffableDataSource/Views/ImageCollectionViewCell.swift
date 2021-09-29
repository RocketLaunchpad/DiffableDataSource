//
//  ImageCollectionViewCell.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/28/21.
//

import Then
import UIKit
import UIKitExtensions

class ImageCollectionViewCell: CollectionViewCell, ModelConfigurableCollectionViewCell {

    private let _imageView = UIImageView(frame: .zero).forAutoLayout().then {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .link
    }

    private let _titleLabel = UILabel(frame: .zero).forAutoLayout().then {
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = .preferredFont(forTextStyle: .headline)
    }

    override func cellDidLoad() {
        super.cellDidLoad()
        addArrangedSubviews(_imageView, _titleLabel)

        NSLayoutConstraint.activate([
            _imageView.heightAnchor.constraint(equalToConstant: 64),
        ])
    }

    func configure(with model: ImageModel) {
        _imageView.image = model.image
        _titleLabel.text = model.title
    }
}

//
//  ImageTableViewCell.swift
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
import UIKitExtensions

class ImageTableViewCell: TableViewCell {

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
}

extension ImageTableViewCell: ModelConfigurableTableViewCell {

    func configure(with model: ImageModel) {
        _imageView.image = model.image
        _titleLabel.text = model.title
    }
}

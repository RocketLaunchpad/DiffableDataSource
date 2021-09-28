//
//  TextCell.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/24/21.
//

import UIKit

class TextCell: TableViewCell, ModelConfigurableTableViewCell {

    private let _titleLabel = UILabel(frame: .zero).forAutoLayout().then {
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = .preferredFont(forTextStyle: .title1)
    }

    private let _bodyLabel = UILabel(frame: .zero).forAutoLayout().then {
        $0.numberOfLines = 0
        $0.font = .preferredFont(forTextStyle: .body)
    }

    override func cellDidLoad() {
        super.cellDidLoad()
        addArrangedSubviews(_titleLabel, _bodyLabel)
    }

    func configure(with model: TextModel) {
        _titleLabel.text = model.title
        _bodyLabel.text = model.body
    }
}

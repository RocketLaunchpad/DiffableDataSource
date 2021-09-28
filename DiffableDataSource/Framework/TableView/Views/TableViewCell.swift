//
//  TableViewCell.swift
//  DiffableDataSource
//
//  Created by Paul Calnan on 9/24/21.
//

import Then
import UIKit
import UIKitExtensions

/// Default table view cell. Wraps a vertical stack view intended to contain subviews.
class TableViewCell: UITableViewCell {

    /// The vertical stack view where subviews are to be added.
    let stackView = UIStackView().forAutoLayout().then {
        $0.axis = .vertical
        $0.spacing = 16
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
        ])

        cellDidLoad()
    }

    /// Convenience function to add each of the views to the stack view.
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {
            stackView.addArrangedSubview($0)
        }
    }

    /// Called after the view is loaded. Subclasses should override this function and add its UI elements to the stack view.
    func cellDidLoad() { }
}
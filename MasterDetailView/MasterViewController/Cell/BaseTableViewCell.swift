//
//  BaseTableViewCell.swift
//  MasterDetailView
//
//  Created by Vlad Gushchin on 30.10.2019.
//  Copyright © 2019 Vlad Gushchin. All rights reserved.
//

import UIKit

@objc protocol BaseTableViewCellDelegate: class {
    @objc optional func prepareForReuse(with indexPath: IndexPath)
}

class BaseTableViewCell: UITableViewCell {
    @IBOutlet var verticalConstraints: [NSLayoutConstraint]!
    weak var delegate: BaseTableViewCellDelegate?
    var indexPath: IndexPath?
    var height: CGFloat?
    var verticalConstraintsHeight: CGFloat = 0.0

    func setup(with model: BaseCellModel) {
        fatalError("Need to override")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.updateConstraints()
        self.verticalConstraintsHeight = verticalConstraints.height
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        guard let indexPath = self.indexPath else { return }
        self.delegate?.prepareForReuse?(with: indexPath)
    }

    @discardableResult
    func calculateHeight() -> CGFloat {
        return 0.0
    }
}

extension Array where Element == NSLayoutConstraint {
    var height: CGFloat {
        return self.reduce(0.0) { value, next in
            return value + next.constant
        }
    }
}

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

    func setup(with model: BaseCellModel) {
        fatalError("Need to override")
    }

    var height: CGFloat {
        return 0.0
    }

    var verticalConstraintsHeight: CGFloat = 0.0

    override func awakeFromNib() {
        super.awakeFromNib()
        self.verticalConstraintsHeight = verticalConstraints.height
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        guard let indexPath = self.indexPath else { return }
        self.delegate?.prepareForReuse?(with: indexPath)
    }
}

extension Array where Element == NSLayoutConstraint {
    var height: CGFloat {
        return self.reduce(0.0) { value, next in
            return value + next.constant
        }
    }
}

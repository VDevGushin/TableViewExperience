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
    private var style = NSMutableParagraphStyle()

    var verticalConstraintsHeight: CGFloat = 0.0

    var calculatedHeight: CGFloat?

    var height: CGFloat {
        return 0.0
    }


    func setup(with model: BaseCellModel) {
        fatalError("Need to override")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.updateConstraints()
        self.verticalConstraintsHeight = verticalConstraints.height
        style.lineBreakMode = .byWordWrapping
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        guard let indexPath = self.indexPath else { return }
        self.delegate?.prepareForReuse?(with: indexPath)
    }

    func calculateHeight() -> CGFloat {
        return 0.0
    }

    func height(text: String, withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {

        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: self.style], context: nil)

        return ceil(boundingBox.height)
//        self.label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
//        self.label?.numberOfLines = 0
//        self.label?.lineBreakMode = .byWordWrapping
//        self.label?.font = font
//        self.label?.text = text
//        self.label?.sizeToFit()
//        return self.label?.frame.height ?? 0.0
    }
}

extension Array where Element == NSLayoutConstraint {
    var height: CGFloat {
        return self.reduce(0.0) { value, next in
            return value + next.constant
        }
    }
}

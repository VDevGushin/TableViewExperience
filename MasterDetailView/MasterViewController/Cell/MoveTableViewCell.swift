//
//  MoveTableViewCell.swift
//  MasterDetailView
//
//  Created by Vlad Gushchin on 30.10.2019.
//  Copyright © 2019 Vlad Gushchin. All rights reserved.
//

import UIKit

final class MoveTableViewCell: BaseTableViewCell {
    @IBOutlet private var fromPlaceLabel: UILabel!
    @IBOutlet private var toPlaceLabel: UILabel!
    @IBOutlet private var estimateTimeLabel: UILabel!

    override func setup(with model: BaseCellModel) {
        guard let model = model as? Move else { return }
        self.fromPlaceLabel.text = "Вылет из: " + (model.fromPlace ?? "_")
        self.toPlaceLabel.text = "Прилет в: " + (model.toPlace ?? "_")
        self.estimateTimeLabel.text = "Время в пути: " + stringFromTimeInterval(interval: model.estimateTime)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func stringFromTimeInterval(interval: TimeInterval?) -> String {
        guard let interval = interval else {
            return "_"
        }

        let ti = NSInteger(interval)

        let ms = Int((interval.truncatingRemainder(dividingBy: 1)) * 1000)

        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)

        return String(format: "%0.2d:%0.2d:%0.2d.%0.3d", hours, minutes, seconds, ms)
    }

    override var height: CGFloat {
        var height: CGFloat = super.verticalConstraintsHeight

        if let fromPlaceLabel = self.fromPlaceLabel
            , let fromPlaceLabelText = fromPlaceLabel.text {
            height += fromPlaceLabelText.height(withConstrainedWidth: fromPlaceLabel.frame.width, font: fromPlaceLabel.font)
        }

        if let toPlaceLabel = self.toPlaceLabel
            , let toPlaceLabelText = toPlaceLabel.text {
            height += toPlaceLabelText.height(withConstrainedWidth: toPlaceLabel.frame.width, font: toPlaceLabel.font)
        }

        return height
    }
}

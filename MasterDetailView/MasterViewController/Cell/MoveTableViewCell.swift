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
    var model: Move?

    override func setup(with model: BaseCellModel) {
        guard let model = model as? Move else { return }
        self.model = model
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
        var calculateHeight = super.verticalConstraintsHeight

        if let fromPlaceLabel = self.fromPlaceLabel
            , let fromPlaceLabelText = self.model?.fromPlace,
            !fromPlaceLabelText.isEmpty {
            let h = height(text: fromPlaceLabelText, withConstrainedWidth: fromPlaceLabel.frame.width, font: fromPlaceLabel.font)
            calculateHeight += h
        }

        if let toPlaceLabel = self.toPlaceLabel
            , let toPlaceLabelText = self.model?.toPlace {
            let h = height(text: toPlaceLabelText, withConstrainedWidth: toPlaceLabel.frame.width, font: toPlaceLabel.font)
            calculateHeight += h
        }

        return calculateHeight
    }


    override func calculateHeight() -> CGFloat {
        if calculatedHeight != nil {
            return calculatedHeight!
        }

        var calculateHeight = super.verticalConstraintsHeight

        if let fromPlaceLabel = self.fromPlaceLabel
            , let fromPlaceLabelText = fromPlaceLabel.text,
            !fromPlaceLabelText.isEmpty {
            calculateHeight += height(text: fromPlaceLabelText, withConstrainedWidth: fromPlaceLabel.frame.width, font: fromPlaceLabel.font)
        } else {
            calculateHeight += 20
        }

        if let toPlaceLabel = self.toPlaceLabel
            , let toPlaceLabelText = toPlaceLabel.text, !toPlaceLabelText.isEmpty {
            calculateHeight += height(text: toPlaceLabelText, withConstrainedWidth: toPlaceLabel.frame.width, font: toPlaceLabel.font)
        } else {
            calculateHeight += 20
        }

        self.calculatedHeight = calculateHeight
        return calculateHeight
    }
}

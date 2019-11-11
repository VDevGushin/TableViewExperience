//
//  NoticeTableViewCell.swift
//  MasterDetailView
//
//  Created by Vlad Gushchin on 30.10.2019.
//  Copyright © 2019 Vlad Gushchin. All rights reserved.
//

import UIKit

final class NoticeTableViewCell: BaseTableViewCell {
    @IBOutlet private var flightDateLabel: UILabel!
    @IBOutlet private var gateLabel: UILabel!

    override func setup(with model: BaseCellModel) {
        guard let model = model as? Notice else { return }

        self.flightDateLabel.text = "Время вылета: " + (model.dateStrValue ?? "_")
        self.gateLabel.text = "Ворота: " + (model.gate ?? "_")
    }

    override var height: CGFloat {
        var calculateHeight = super.verticalConstraintsHeight

        if let flightLabel = self.flightDateLabel
            , let flightLabelText = flightLabel.text {
            calculateHeight += height(text: flightLabelText, withConstrainedWidth: flightLabel.frame.width, font: flightLabel.font)
        }


        if let gateLabel = self.gateLabel, let gateLabelText = gateLabel.text {
            calculateHeight += height(text: gateLabelText, withConstrainedWidth: gateLabel.frame.width, font: gateLabel.font)
        }

        return calculateHeight
    }

    override func calculateHeight() -> CGFloat {
        if calculatedHeight != nil {
            return calculatedHeight!
        }

        var calculateHeight = super.verticalConstraintsHeight

        if let flightLabel = self.flightDateLabel
            , let flightLabelText = flightLabel.text {
            calculateHeight += height(text: flightLabelText, withConstrainedWidth: flightLabel.frame.width, font: flightLabel.font)
        }


        if let gateLabel = self.gateLabel, let gateLabelText = gateLabel.text {
            calculateHeight += height(text: gateLabelText, withConstrainedWidth: gateLabel.frame.width, font: gateLabel.font)
        }

        self.calculatedHeight = calculateHeight
        return calculateHeight
    }
}


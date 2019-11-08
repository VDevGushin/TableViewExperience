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

        self.flightDateLabel.text = "Время вылета: " + (model.flightDate?.strValue ?? "_")
        self.gateLabel.text = "Ворота: " + (model.gate ?? "_")
    }

    override var height: CGFloat {

        var height: CGFloat = super.verticalConstraintsHeight

        if let flightLabel = self.flightDateLabel
            , let flightLabelText = flightLabel.text {
            height += flightLabelText.height(withConstrainedWidth: flightLabel.frame.width, font: flightLabel.font)
        }


        if let gateLabel = self.gateLabel, let gateLabelText = gateLabel.text {
            height += gateLabelText.height(withConstrainedWidth: gateLabel.frame.width, font: gateLabel.font)
        }

        return height
    }
}


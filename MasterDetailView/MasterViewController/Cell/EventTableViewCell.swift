//
//  EventTableViewCell.swift
//  MasterDetailView
//
//  Created by Vlad Gushchin on 30.10.2019.
//  Copyright © 2019 Vlad Gushchin. All rights reserved.
//

import UIKit

final class EventTableViewCell: BaseTableViewCell {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var startTimeLabel: UILabel!
    @IBOutlet private var endTimeLabel: UILabel!

    override func setup(with model: BaseCellModel) {
        guard let model = model as? Event else { return }
        self.nameLabel.text = "Название: " + (model.name ?? "_")
        self.startTimeLabel.text = "Начало: " + (model.startTimeStr ?? "_")
        self.endTimeLabel.text = "Конец: " + (model.endTimeStr ?? "_")
    }

    override func calculateHeight() -> CGFloat {
        guard self.height == nil else {
            return self.height!
        }

        var calculateHeight = super.verticalConstraintsHeight

        if let nameLabel = self.nameLabel
            , let nameLabelText = nameLabel.text {
            calculateHeight += nameLabelText.height(withConstrainedWidth: nameLabel.frame.width, font: nameLabel.font)
        }

        if let startTimeLabel = self.startTimeLabel, let startTimeLabelText = startTimeLabel.text {
            calculateHeight += startTimeLabelText.height(withConstrainedWidth: startTimeLabel.frame.width, font: startTimeLabel.font)
        }

        if let endTimeLabel = self.endTimeLabel, let endTimeLabelText = endTimeLabel.text {
            calculateHeight += endTimeLabelText.height(withConstrainedWidth: endTimeLabel.frame.width, font: endTimeLabel.font)
        }

        self.height = calculateHeight
        return calculateHeight
    }
}

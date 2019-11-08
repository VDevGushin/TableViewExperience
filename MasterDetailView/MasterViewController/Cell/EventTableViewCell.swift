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
        self.startTimeLabel.text = "Начало: " + (model.startTime?.strValue ?? "_")
        self.endTimeLabel.text = "Конец: " + (model.endTime?.strValue ?? "_")
    }


    override var height: CGFloat {
        var height: CGFloat = super.verticalConstraintsHeight

        if let nameLabel = self.nameLabel
            , let nameLabelText = nameLabel.text {
            height += nameLabelText.height(withConstrainedWidth: nameLabel.frame.width, font: nameLabel.font)
        }

        if let startTimeLabel = self.startTimeLabel, let startTimeLabelText = startTimeLabel.text {
            height += startTimeLabelText.height(withConstrainedWidth: startTimeLabel.frame.width, font: startTimeLabel.font)
        }

        if let endTimeLabel = self.endTimeLabel, let endTimeLabelText = endTimeLabel.text {
            height += endTimeLabelText.height(withConstrainedWidth: endTimeLabel.frame.width, font: endTimeLabel.font)
        }

        return height
    }
}

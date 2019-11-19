//
//  GenericCellsModels.swift
//  MasterDetailView
//
//  Created by Владислав on 19.11.2019.
//  Copyright © 2019 Vlad Gushchin. All rights reserved.
//

import UIKit

class GenericCell<Model>: UITableViewCell {
    var model: Model?
    func attach(model: Model?) { }
    func detach(model: Model?) { }
}


// MARK: - Notice models
class NoticeModelCell: GenericCell<NoticeModel> {
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var subTitleLabel: UILabel?

    override func attach(model: NoticeModel?) {
        self.titleLabel?.text = model?.title
        self.subTitleLabel?.text = model?.subTitle
    }

    override func detach(model: NoticeModel?) {
        print(#function)
    }
}

// MARK: - Move models

class MoveModelCell: GenericCell<MoveModel> {
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var subTitleLabel: UILabel?

    override func attach(model: MoveModel?) {
        self.titleLabel?.text = model?.title
        self.subTitleLabel?.text = model?.subTitle
    }

    override func detach(model: MoveModel?) {
        print(#function)
    }
}

//
//  GenericCellsModels.swift
//  MasterDetailView
//
//  Created by Владислав on 19.11.2019.
//  Copyright © 2019 Vlad Gushchin. All rights reserved.
//

import UIKit

class XibCellGenericModel {
    var xibName: String { get { fatalError() } }
    func attach<Cell>(cell: Cell) { print(#function) }
    func detach<Cell>(cell: Cell) { print(#function) }
}

class GenericCell<CellModel>: UITableViewCell {
    func attach(model: CellModel?) { }
    func detach(model: CellModel?) { }
}

// MARK: - Notice models
final class NoticeModelCell: GenericCell<NoticeModelCell.ModelForNoticeCell> {
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var subTitleLabel: UILabel?

    override func attach(model: ModelForNoticeCell?) {
        self.titleLabel?.text = model?.title
        self.subTitleLabel?.text = model?.subTitle
    }

    override func detach(model: ModelForNoticeCell?) {
        print(#function)
    }
}

extension NoticeModelCell {
    final class ModelForNoticeCell: XibCellGenericModel {
        override var xibName: String { return "NoticeModelCell" }
        let title: String
        let subTitle: String

        init(title: String, subTitle: String) {
            self.title = title
            self.subTitle = subTitle
        }

        override func attach<Cell:NoticeModelCell>(cell: Cell) {
            cell.attach(model: self)
        }

        override func detach<Cell: NoticeModelCell>(cell: Cell) {
            cell.detach(model: self)
        }
    }
}

// MARK: - Move models

final class MoveModelCell: GenericCell<MoveModelCell.ModelForMoveCell> {
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var subTitleLabel: UILabel?

    override func attach(model: MoveModelCell.ModelForMoveCell?) {
        self.titleLabel?.text = model?.title
        self.subTitleLabel?.text = model?.subTitle
    }

    override func detach(model: MoveModelCell.ModelForMoveCell?) {
        print(#function)
    }
}

extension MoveModelCell {
    final class ModelForMoveCell: XibCellGenericModel {
        override var xibName: String { return "NoticeModelCell" }
        let title: String
        let subTitle: String

        init(title: String, subTitle: String) {
            self.title = title
            self.subTitle = subTitle
        }

        override func attach<Cell:MoveModelCell>(cell: Cell) {
            cell.attach(model: self)
        }

        override func detach<Cell: MoveModelCell>(cell: Cell) {
            cell.detach(model: self)
        }
    }
}

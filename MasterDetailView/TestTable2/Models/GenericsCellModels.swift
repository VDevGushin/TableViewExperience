//
//  GenericsCellModels.swift
//  MasterDetailView
//
//  Created by Владислав on 19.11.2019.
//  Copyright © 2019 Vlad Gushchin. All rights reserved.
//

import UIKit


// MARK: - Base
protocol BaseCellModelEmbeded {
    associatedtype Cell: UITableViewCell
    func attach(cell: Cell)
    func detach(cell: Cell)
}

// MARK: - Notise
struct NoticeModel: BaseCellModelEmbeded {
    typealias Cell = NoticeModelCell
    let title: String
    let subTitle: String

    func attach(cell: NoticeModelCell) {
        cell.attach(model: self)
    }

    func detach(cell: NoticeModelCell) {
        cell.detach(model: self)
    }
}

// MARK: - Move

struct MoveModel: BaseCellModelEmbeded {
    typealias Cell = MoveModelCell
    let title: String
    let subTitle: String

    func attach(cell: MoveModelCell) {
        cell.attach(model: self)
    }

    func detach(cell: MoveModelCell) {
        cell.detach(model: self)
    }
}

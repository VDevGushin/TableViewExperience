//
//  GenericsCellModels.swift
//  MasterDetailView
//
//  Created by Владислав on 19.11.2019.
//  Copyright © 2019 Vlad Gushchin. All rights reserved.
//

import UIKit


// MARK: - Base
protocol BaseModel { }

// MARK: - Notise
struct NoticeModel: BaseModel {
    let title: String
    let subTitle: String
}

// MARK: - Move
struct MoveModel: BaseModel {
    let title: String
    let subTitle: String
}


let source: [BaseModel] = [NoticeModel(title: "test1", subTitle: "test2"), MoveModel(title: "test1", subTitle: "test2")]

extension Array where Element == BaseModel {
    func make() -> [XibCellGenericModel] {
        var result = [XibCellGenericModel]()
        for element in self {
            if let move = element as? MoveModel {
                result.append(MoveModelCell.ModelForMoveCell(title: move.title, subTitle: move.subTitle))
            }
            if let notice = element as? NoticeModel {
                result.append(NoticeModelCell.ModelForNoticeCell(title: notice.title, subTitle: notice.subTitle))
            }
        }
        return result
    }
}

extension Array where Element: XibCellGenericModel {
    var xibNames: [String] {
        return self.map { $0.xibName }
    }
}

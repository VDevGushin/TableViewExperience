//
//  CellManager.swift
//  MasterDetailView
//
//  Created by Vlad Gushchin on 30.10.2019.
//  Copyright © 2019 Vlad Gushchin. All rights reserved.
//

import UIKit

enum CellManagerXibType: String {
    case noticeCell = "NoticeTableViewCell"
    case eventCell = "EventTableViewCell"
    case moveCell = "MoveTableViewCell"

    init(with: BaseModelType) {
        switch with {
        case .notice:
            self = .noticeCell
        case .event:
            self = .eventCell
        case .move:
            self = .moveCell
        }
    }

    var value: String { return self.rawValue }
}

class CellManager {
    typealias XibNames = Set<String>
    private var cellHeights: [Int: CGFloat] = [:]

    func clear() {
        self.cellHeights = [:]
    }

    func registerCells(tableView: UITableView?, with xibNames: XibNames) {
        xibNames.forEach {
            tableView?.register(UINib(nibName: $0, bundle: nil), forCellReuseIdentifier: $0)
        }
    }

    func getCell(tableView: UITableView, model: BaseCellModel, indexPath: IndexPath) -> UITableViewCell {
        let id = CellManagerXibType(with: model.modelType!).value
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as! BaseTableViewCell
        cell.setup(with: model)
        cell.indexPath = indexPath
        cell.delegate = self
        self.cellHeights[indexPath.row] = cell.height
        return cell
    }

    func getCellHeight(indexPath: IndexPath) -> CGFloat {
        self.cellHeights[indexPath.row] ?? 0.0
    }
}

extension CellManager: BaseTableViewCellDelegate {}

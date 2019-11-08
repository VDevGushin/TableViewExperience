//
//  TableManager.swift
//  MasterDetailView
//
//  Created by Vlad Gushchin on 06.11.2019.
//  Copyright © 2019 Vlad Gushchin. All rights reserved.
//

import UIKit


final class TableManager {
    private unowned let tableView: UITableView
    private let modelManager: ModelManager
    private let cellManager: CellManager

    init(modelManager: ModelManager, cellManager: CellManager, tableView: UITableView) {
        self.modelManager = modelManager
        self.cellManager = cellManager
        self.tableView = tableView
    }

    func clearAll() {
        self.modelManager.clear()
        self.cellManager.clear()
    }

    func addNew(source: [BaseCellModel],
        on queue: DispatchQueue = .global(qos: .utility),
        completion: @escaping (Bool, [IndexPath]) -> Void) {

        queue.async { [weak self] in
            guard let self = self else { return }
            let (newIndexPaths, xibNames) = self.modelManager.load(with: source)
            let isContains = newIndexPaths.contains(where: { $0.row == 0 && $0.section == 0 })

            DispatchQueue.main.async {
                self.cellManager.registerCells(tableView: self.tableView, with:  xibNames)
                completion(isContains, newIndexPaths)
            }
        }
    }
}

extension TableManager {
    var dataSourceCount: Int {
        self.modelManager.dataSourceCount
    }

    subscript(index: Int) -> BaseCellModel {
        return self.modelManager[index]
    }
}

extension TableManager {
    func getCell(model: BaseCellModel, indexPath: IndexPath) -> UITableViewCell {
        return self.cellManager.getCell(tableView: self.tableView, model: model, indexPath: indexPath)
    }

    func getCellHeight(indexPath: IndexPath) -> CGFloat {
        return self.cellManager.getCellHeight(indexPath: indexPath)
    }
}

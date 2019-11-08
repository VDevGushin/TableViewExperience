//
//  ModelMalager.swift
//  MasterDetailView
//
//  Created by Vlad Gushchin on 30.10.2019.
//  Copyright © 2019 Vlad Gushchin. All rights reserved.
//

import UIKit

class ModelManager {
    typealias LoadData = ([IndexPath], Set<String>)
    private var source: [BaseCellModel] = []

    var dataSourceCount: Int {
        return self.source.count
    }

    subscript(index: Int) -> BaseCellModel {
        get { return self.source[index] }
    }

    func clear() {
        self.source = []
    }

    func load(with source: [BaseCellModel]) -> LoadData {
        var indexPaths = [IndexPath]()
        var xibNames = Set<String>()
        var startIndex = self.source.count > 0 ? self.source.count : 0
        for item in source where item.modelType != nil {
            self.source.append(item)
            xibNames.insert(CellManagerXibType(with: item.modelType!).value)
            indexPaths.append(IndexPath(row: startIndex, section: 0))
            startIndex += 1
        }

        print(indexPaths.first?.row ?? 0.0)
        print(indexPaths.last?.row ?? 0.0)
        return (indexPaths, xibNames)
    }
}

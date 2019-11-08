//
//  FakeGenerator.swift
//  MasterDetailView
//
//  Created by Vlad Gushchin on 24.10.2019.
//  Copyright © 2019 Vlad Gushchin. All rights reserved.
//

import Foundation

protocol FakeGenerator {
    func generate() -> [BaseCellModel]
}

final class FightGenerator: FakeGenerator {
    private let cellGenerator: CellGenerator = FightCellGenerator()

    func generate() -> [BaseCellModel] {
        let totalCount = Int.random(in: 30...100)

        var buffer = [BaseCellModel]()

        for _ in 0..<totalCount {
            let cellType = Int.random(in: 0...3)
            let model = cellGenerator.generateCell(with: FightCellGenerator.CellType(rawValue: cellType) ?? FightCellGenerator.CellType.event)
            buffer.append(model)
        }

        return buffer
    }
}

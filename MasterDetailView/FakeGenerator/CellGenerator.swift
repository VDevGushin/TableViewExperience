//
//  CellGenerator.swift
//  MasterDetailView
//
//  Created by Vlad Gushchin on 24.10.2019.
//  Copyright © 2019 Vlad Gushchin. All rights reserved.
//

import Foundation

protocol CellGenerator {
    func generateCell(with type: FightCellGenerator.CellType) -> BaseCellModel
}

struct FightCellGenerator: CellGenerator {
    enum CellType: Int {
        case notice
        case event
        case move
        case newCellClass
    }

    func generateCell(with type: CellType) -> BaseCellModel {
        switch type {
        case .notice:
            return Notice(flightDate: Date(), gate: String.gate)
        case .event:
            return Event(name: "EventName", startTime: Date(), endTime: Date.tomorrow)
        case .move:
            return Move(fromPlace: String.place, toPlace: String.place, estimateTime:
                    123)
        case .newCellClass:
            return NewCellClass(text: String.place ?? "")
        }
    }
}

//Шуточные помошники для заполнения разными полями модельки))
fileprivate extension String {
    static var gate: String? {
        return Int.random(in: 0...1) > 0 ? "A" : nil
    }

    static var place: String? {
        let textLenght = Int.random(in: 10...20)
        var text = ""
        for _ in 0..<10 {
            text += "привет "
        }
        //return Int.random(in: 0...1) > 0 ? text : nil
        return text
    }
}

fileprivate extension Date {
    static var tomorrow: Date { return Date().dayAfter }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
}

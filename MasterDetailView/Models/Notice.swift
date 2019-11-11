//
//  Notice.swift
//  MasterDetailView
//
//  Created by Vlad Gushchin on 24.10.2019.
//  Copyright © 2019 Vlad Gushchin. All rights reserved.
//

import UIKit

struct Notice: BaseCellModel {
    var flightDate: Date?
    var gate: String?

    var dateStrValue: String?

    init(flightDate: Date?, gate: String?) {
        self.flightDate = flightDate
        self.gate = gate
        self.dateStrValue = flightDate?.strValue
    }
}

//
//  Move.swift
//  MasterDetailView
//
//  Created by Vlad Gushchin on 24.10.2019.
//  Copyright © 2019 Vlad Gushchin. All rights reserved.
//

import UIKit

struct Move: BaseCellModel {
    var fromPlace: String?
    var toPlace: String?
    var estimateTime: TimeInterval?

    init(fromPlace: String?, toPlace: String?, estimateTime: TimeInterval?) {
        self.fromPlace = fromPlace
        self.toPlace = toPlace
        self.estimateTime = estimateTime
    }
}

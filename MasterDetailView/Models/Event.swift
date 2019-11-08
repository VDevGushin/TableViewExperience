//
//  Event.swift
//  MasterDetailView
//
//  Created by Vlad Gushchin on 24.10.2019.
//  Copyright © 2019 Vlad Gushchin. All rights reserved.
//

import UIKit

struct Event: BaseCellModel {
    var name: String?
    var startTime: Date?
    var endTime: Date?

    //for test generators
    init(name: String?, startTime: Date?, endTime: Date?) {
        self.name = name
        self.startTime = startTime
        self.endTime = endTime
    }
}

//
//  BaseCellModel.swift
//  MasterDetailView
//
//  Created by Vlad Gushchin on 24.10.2019.
//  Copyright © 2019 Vlad Gushchin. All rights reserved.
//

import UIKit

protocol BaseCellModel {
    var modelType: BaseModelType? { get }
}

extension BaseCellModel {
    var modelType: BaseModelType? {
        return BaseModelType(rawValue: String(describing: Self.self))
    }
}

enum BaseModelType: String {
    case notice = "Notice"
    case event = "Event"
    case move = "Move"
}

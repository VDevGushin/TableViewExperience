//
//  UIStackView+Ex.swift
//  MasterDetailView
//
//  Created by Vlad Gushchin on 24.10.2019.
//  Copyright © 2019 Vlad Gushchin. All rights reserved.
//

import UIKit

extension UIStackView {
    func removeAllSubviews() {
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
    }
}

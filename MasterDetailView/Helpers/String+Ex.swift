//
//  String+Ex.swift
//  MasterDetailView
//
//  Created by Vlad Gushchin on 30.10.2019.
//  Copyright © 2019 Vlad Gushchin. All rights reserved.
//

import UIKit

extension String {

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}

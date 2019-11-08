//
//  TableView+Ex.swift
//  MasterDetailView
//
//  Created by Vlad Gushchin on 24.10.2019.
//  Copyright © 2019 Vlad Gushchin. All rights reserved.
//

import UIKit

//Я понимаю, что тибы могут тормозить и эти штуки можно создавать кодом,
//Но для скорости выполнения задачи я выбрал nib

extension UITableView {
    func registerWithNibs(_ cellTypes: [UITableViewCell.Type]?) {
        cellTypes?.forEach {
            self.register($0)
        }
    }

    func register(_ cellType: UITableViewCell.Type) {
        let id = String(describing: cellType)
        let nib = UINib(nibName: id, bundle: nil)
        self.register(nib, forCellReuseIdentifier: id)
    }

    func register(_ cellTypes: [UITableViewCell.Type]?) {
        cellTypes?.forEach {
            let id = String(describing: $0.self)
            self.register($0, forCellReuseIdentifier: id)
        }
    }
}

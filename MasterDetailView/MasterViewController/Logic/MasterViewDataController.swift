//
//  MasterViewDataController.swift
//  MasterDetailView
//
//  Created by Vlad Gushchin on 24.10.2019.
//  Copyright © 2019 Vlad Gushchin. All rights reserved.
//

import Foundation

protocol MasterViewDataControllerDelegate: class {
    func masterViewDataController(_ dataController: MasterViewDataController, new data: [BaseCellModel])
}

protocol MasterViewDataController: class {
    var delegate: MasterViewDataControllerDelegate? { get set }
    func fetchNewData()
}

final class FightMasterViewDataController: MasterViewDataController {
    weak var delegate: MasterViewDataControllerDelegate?
    private var isInLoad = false
    private let netwokrService: FakeNetworkLayerOrService
    
    init(netwokrService: FakeNetworkLayerOrService) {
        self.netwokrService = netwokrService
    }

    func fetchNewData() {
        guard !self.isInLoad else { return }
        self.isInLoad.toggle()
        self.netwokrService.fetchFakeData { [weak self] newData in
            //тут можно было бы проверять данные на валдиность и целостность(например если обязательные поля nil) - но я не стал этого делать, так как "напишите простейшее приложение" было в задании
            DispatchQueue.main.async {
                self?.isInLoad.toggle()
                guard let self = self else {
                    return print("Да эти замыкания надоедают такими конструкциями")
                }
                self.delegate?.masterViewDataController(self, new: newData)
            }
        }
    }
}

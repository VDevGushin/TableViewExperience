//
//  FakeNetworkLayerOrService.swift
//  MasterDetailView
//
//  Created by Vlad Gushchin on 24.10.2019.
//  Copyright © 2019 Vlad Gushchin. All rights reserved.
//

import Foundation

protocol FakeNetworkLayerOrService {
    //можно и через делегаты и т д
    func fetchFakeData(completion: @escaping ([BaseCellModel]) -> Void)
}

final class NetworkLayerOrService: FakeNetworkLayerOrService {
    private let fakeGeneraror: FakeGenerator

    init() {
        self.fakeGeneraror = FightGenerator()
    }

    func fetchFakeData(completion: @escaping ([BaseCellModel]) -> Void) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else {
                return print("Какой-то лог ошибки об этой проблеме например")
            }
            let models = self.fakeGeneraror.generate()
            completion(models)
        }
    }
}

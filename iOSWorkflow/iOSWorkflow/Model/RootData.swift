//
//  DataController.swift
//  iOSWorkflow
//
//  Created by harofan on 2021/2/9.
//

import SwiftUI
import Combine

class RootData: ObservableObject {
    var lockFileParser = LockFileParser()
    @Published var rowModels: [ModuleRowModel]?
    
    private var podfileLockDataSubscriber: AnyCancellable?
    
    init() {
        setupObservers()
    }
    
    func setupObservers() {
        podfileLockDataSubscriber = lockFileParser.$podfileLockData.sink { value in
            self.updatePods(value?.pods)
        }
    }
}

extension RootData {
    private func updatePods(_ pods: [Pod]?) {
        guard let pods = pods else {
            return
        }
        rowModels = pods.map({
            ModuleRowModel(pod: $0)
        })
    }
}

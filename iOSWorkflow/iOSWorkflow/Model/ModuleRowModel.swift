//
//  ModuleRowModel.swift
//  iOSWorkflow
//
//  Created by harofan on 2021/2/10.
//

import Foundation

class ModuleRowModel: Identifiable {
    private let pod: Pod
    init(pod: Pod) {
        self.pod = pod
    }
    
    var name: String {
        pod.name
    }
    var version: String {
        pod.info?.version ?? ""
    }
}

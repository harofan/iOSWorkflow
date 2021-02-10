//
//  SpecRepo.swift
//  iOSWorkflow
//
//  Created by harofan on 2021/2/10.
//

import Foundation

struct SpecRepo {
    var repo: String
    var pods: [String]

    init(repo: String, pods: [String]) {
        self.repo = repo
        self.pods = pods
    }
}

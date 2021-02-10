//
//  PodfileLock.swift
//  iOSWorkflow
//
//  Created by harofan on 2021/2/10.
//

enum PodfileLockRootKey: String {
    case pods = "PODS"
    case dependencies = "DEPENDENCIES"
    case specRepos = "SPEC REPOS"
    case externalSources = "EXTERNAL SOURCES"
    case checkoutOptions = "CHECKOUT OPTIONS"
    case specChecksums = "SPEC CHECKSUMS"
    case cocoapods = "COCOAPODS"
}

struct PodfileLock {
    var pods: [Pod] = []
    var dependencies: [Pod] = []
    var specRepos: [SpecRepo] = []
    var externalSources: [String: [String: String]] = [:]
    var checkoutOptions: [String: [String: String]] = [:]
    var specChecksums: [String: String] = [:]
    var cocoapods: String = ""
}

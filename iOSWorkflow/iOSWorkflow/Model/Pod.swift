//
//  Pod.swift
//  iOSWorkflow
//
//  Created by harofan on 2021/2/10.
//

import Foundation

enum PodImportType: Hashable {
    case loaclSource(localPath: String)
    case specBin(specGitRepo: String)
    case gitBin(gitRepo: String)
    case gitSource(gitRepo: String)
}

class Pod {
    struct Info: Hashable, Codable {
        var version: String
        var name: String {
            version
        }

        init(version: String) {
            self.version = version
        }
    }

    var name: String
    var info: Info?
    var dependencies: [String]?
    var infecteds: [String]?
    var importType: PodImportType?

    init(podValue: String) {
        (name, info) = Self.format(podValue: podValue)
    }

    init?(map: [String: [String]]) {
        if let podValue = map.keys.first {
            (name, info) = Self.format(podValue: podValue)
            self.dependencies = map[podValue]?.map { Self.format(podValue: $0).name }
        } else {
            return nil
        }
    }
}

extension Pod: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(info)
        hasher.combine(name)
        hasher.combine(dependencies)
        hasher.combine(infecteds)
        hasher.combine(importType)
    }

    static func == (lhs: Pod, rhs: Pod) -> Bool {
        if lhs.info == rhs.info,
        lhs.name == rhs.name,
        lhs.dependencies == rhs.dependencies,
        lhs.infecteds == rhs.infecteds,
        lhs.importType == rhs.importType {
            return true
        }
        return false
    }
}

private extension Pod {
    static func format(podValue: String) -> (name: String, version: Info?) {
        if let index = podValue.firstIndex(of: " ") {
            let name = String(podValue[..<index])
            let info: Info = Info(version: String(podValue[index...]).trimmingCharacters(in: .whitespaces))
            return (name, info)
        } else {
            return (podValue, nil)
        }
    }
}

extension Pod {
    func nextLevel(_ isImpactMode: Bool) -> [String]? {
        isImpactMode ? infecteds : dependencies
    }
}

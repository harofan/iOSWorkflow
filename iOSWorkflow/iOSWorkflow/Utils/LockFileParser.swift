//
//  LockFileParser.swift
//  iOSWorkflow
//
//  Created by harofan on 2021/2/9.
//

import Foundation
import Yams

let supportType: String = kUTTypeFileURL as String

class LockFileParser {
    private var bookmarkData: Data?
    private var lockFileUrl: URL? {
        didSet {
            loadFile()
        }
    }
    private var queue = DispatchQueue(label: "lockfile_parse_quque")
    private(set) var isLoading = false
    @Published private(set) var podfileLockData: PodfileLock?
    
    func loadPath(from items: [NSItemProvider]) -> Bool {
        guard let item = items.first(where: { $0.canLoadObject(ofClass: URL.self) }) else { return false }
        item.loadItem(forTypeIdentifier: supportType, options: nil) { (data, error) in
            if let _ = error {
                return
            }
            
            guard let urlData = data as? Data,
                  let urlString = String(data: urlData, encoding: .utf8),
                  let url = URL(string: urlString) else {
                return
            }
            
            guard url.lastPathComponent == "Podfile.lock" else {
                return
            }
            
            if let bookmarkData = BookmarkTool.bookmark(for: url) {
                DispatchQueue.main.async {
                    self.bookmarkData = bookmarkData
                }
            }
            self.lockFileUrl = url
        }
        return true
    }
    
    func loadFile() {
        guard let fileUrl = lockFileUrl else { return }
        
        isLoading = true
        self.queue.async {
            let lockContent: String
            do {
                lockContent = try String(contentsOf: fileUrl)
            } catch {
                lockContent = ""
                print(error)
                return
            }
            
            let yaml: [String: Any]
            do {
                yaml = try Yams.load(yaml: lockContent) as? [String: Any] ?? [:]
            } catch {
                print(error)
                return
            }
            
            var podfileLockData = PodfileLock()
            if let pods = yaml[PodfileLockRootKey.pods.rawValue] as? [Any] {
                self.readPods(from: pods, with: &podfileLockData)
            }
            DispatchQueue.main.async {
                self.podfileLockData = podfileLockData
            }
        }
    }
    
    @discardableResult
    private func readPods(from pods: [Any], with lock: inout PodfileLock) -> Bool {
        var infecteds = [String: [String]]()
        for content in pods {
            if let string = content as? String {
                lock.pods.append(Pod(podValue: string))
            } else if let map = content as? [String: [String]] {
                if let pod = Pod(map: map) {
                    lock.pods.append(pod)
                    pod.dependencies?.forEach { (name) in
                        var content = infecteds[name] ?? []
                        content.append(pod.name)
                        infecteds[name] = content
                    }
                }
            } else {
                assert(false, "Get unknown data: \(content)")
            }
        }

        infecteds.forEach { arg in
            if let index = lock.pods.firstIndex(where: { $0.name == arg.key }) {
                lock.pods[index].infecteds = arg.value
            }
        }
        return true
    }
    
    func readRepoSpec() {
        
    }
}

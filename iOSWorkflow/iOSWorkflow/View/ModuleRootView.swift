//
//  ModuleRootView.swift
//  iOSWorkflow
//
//  Created by harofan on 2021/2/9.
//

import SwiftUI

struct ModuleRootView: View {
    @StateObject var rootData: RootData
    var body: some View {
        ZStack {
            HStack {
                DropView(rootData: rootData)
                if rootData.rowModels != nil {
                    Divider()
                    ModuleOperationView(rootData: rootData)
                        .frame(minWidth: 900, minHeight: 900)
//                        .background(Color.red)
                }
            }
        }
        .frame(minHeight: 300, maxHeight: .infinity)
    }
}

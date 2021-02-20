//
//  ModuleOperationView.swift
//  iOSWorkflow
//
//  Created by harofan on 2021/2/10.
//

import SwiftUI

struct ModuleOperationView: View {
    @StateObject var rootData: RootData
    var body: some View {
        GeometryReader { reader in
            VStack {
                // List，用 LazyVGrid 是为了更好的性能
                ScrollView {
                    LazyVGrid(
                        columns: [GridItem(.fixed(reader.size.width))],
                        alignment: .leading,
                        spacing: nil,
                        pinnedViews: [],
                        content: { makeItem() }
                    ).animation(.linear)
                }
            }
        }
//        .frame(minWidth: 550, alignment: .center)
//        .padding(5)
    }
    
    /// 创建Cell
    /// - Returns: Cell
    @inline(__always)
    private func makeItem() -> some View {
        ForEach(rootData.rowModels ?? []) { rowData in
            ModuleOperationRowView(rowData: rowData)
                .frame(minHeight: 48)
            Divider()
        }
    }
}

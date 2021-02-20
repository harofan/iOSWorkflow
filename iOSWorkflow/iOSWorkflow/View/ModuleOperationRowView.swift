//
//  ModuleOperationRowView.swift
//  iOSWorkflow
//
//  Created by harofan on 2021/2/10.
//

import SwiftUI

struct ModuleOperationRowView: View {
    @State var rowData: ModuleRowModel
    @State var isSelect: Bool = false
    var body: some View {
        HStack {
//            Spacer()
            Toggle(isOn: $isSelect, label: {
                Text(rowData.name)
            })
//            Spacer()
            Text(rowData.version)
            Button("置顶") {
                
            }
            Text("master")
            Button("checkout") {
                
            }
            Button("提交") {
                
            }
            Button("集成") {
                
            }
            Button("tag") {
                
            }
        }
//        .background(Color.orange)
        .frame(alignment: .leading)
    }
}

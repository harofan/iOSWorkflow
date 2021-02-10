//
//  ModuleOperationRowView.swift
//  iOSWorkflow
//
//  Created by harofan on 2021/2/10.
//

import SwiftUI

struct ModuleOperationRowView: View {
    @State var rowData: ModuleRowModel
    var body: some View {
        HStack {
            Text(rowData.name)
        }
    }
}

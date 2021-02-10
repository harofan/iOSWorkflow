//
//  DropView.swift
//  iOSWorkflow
//
//  Created by harofan on 2021/2/9.
//

import SwiftUI

struct DropView: View {
    @StateObject var rootData: RootData
    @State private var isTargeted: Bool = false
    
    var body: some View {
        VStack {
            Text("将Podfile.lock拖到这里")
                .frame(minWidth: 250, maxWidth: 250, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
        .onDrop(of: [supportType], isTargeted: $isTargeted, perform: { providers, location in
            self.rootData.lockFileParser.loadPath(from: providers)
        })
    }
}

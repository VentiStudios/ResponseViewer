//
//  ContentView.swift
//  ResponseViewer
//
//  Created by YiZhiMCQiu on 8/9/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var focusManager: FocusManager = .init()
    @StateObject var dataManager: DataManager = .init()
    
    var body: some View {
        VStack(spacing: 0) {
            TitleBar()
            ResponseView()
        }
        .environmentObject(focusManager)
        .environmentObject(dataManager)
        .contentShape(Rectangle())
        .onTapGesture {
            focusManager.focusedView = nil
        }
    }
}

#Preview {
    ContentView()
}

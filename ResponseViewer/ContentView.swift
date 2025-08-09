//
//  ContentView.swift
//  ResponseViewer
//
//  Created by YiZhiMCQiu on 8/9/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var focusManager = FocusManager.shared
    
    var body: some View {
        VStack(spacing: 0) {
            TitleBar()
            Rectangle()
        }
        .environmentObject(focusManager)
        .contentShape(Rectangle())
        .onTapGesture {
            FocusManager.shared.focusedView = nil
        }
    }
}

#Preview {
    ContentView()
}

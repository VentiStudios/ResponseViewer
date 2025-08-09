//
//  LocationField.swift
//  ResponseViewer
//
//  Created by YiZhiMCQiu on 8/9/25.
//

import SwiftUI

struct LocationField: View {
    @State private var location: String = ""
    @FocusState private var focusField: FocusableView?
    @EnvironmentObject private var focusManager: FocusManager
    private let onSubmit: (URL) -> Void
    
    init(_ onSubmit: @escaping (URL) -> Void) {
        self.onSubmit = onSubmit
    }

    var body: some View {
        ZStack {
            TextField("输入地址", text: $location)
                .textFieldStyle(.plain)
                .focused($focusField, equals: .location)
                .padding(6)
                .onSubmit {
                    if let url = URL(string: location) {
                        focusField = nil
                        onSubmit(url)
                    }
                }
            RoundedRectangle(cornerRadius: 5)
                .stroke((focusField == .location) ? .accent : .border)
                .shadow(color: .accent.opacity(focusField == .location ? 1 : 0), radius: 5)
        }
        .fixedSize(horizontal: false, vertical: true)
        .animation(.spring(duration: 0.2), value: focusField == .location)
        .onChange(of: focusField) { newValue in
            focusManager.focusedView = newValue
        }
        .onChange(of: focusManager.focusedView) { newValue in
            focusField = newValue
        }
    }
}

#Preview {
    LocationField { _ in }
        .padding()
}

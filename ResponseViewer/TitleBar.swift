//
//  TitleBar.swift
//  ResponseViewer
//
//  Created by YiZhiMCQiu on 8/9/25.
//

import SwiftUI

struct TitleBar: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.background)
            DraggableArea()
            HStack {
                LocationField { _ in }
                    .padding(.horizontal, 10)
            }
        }
        .frame(height: 50)
    }
}

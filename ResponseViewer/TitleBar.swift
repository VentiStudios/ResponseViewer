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
                WindowButtonGroup()
                LocationField { _ in }
                    .padding(.leading, 10)
            }
            .padding()
        }
        .frame(height: 50)
    }
}

struct WindowButtonGroup: View {
    @State private var isHovered: Bool = false
    
    var body: some View {
        HStack(spacing: 8) {
            WindowButton(.closeButton, $isHovered)
            WindowButton(.miniaturizeButton, $isHovered)
            WindowButton(.zoomButton, $isHovered)
        }
        .contentShape(Rectangle())
        .onHover { isHovered in
            self.isHovered = isHovered
        }
    }
}

struct WindowButton: View {
    @Binding private var isHovered: Bool
    private let type: NSWindow.ButtonType
    private let backgroundColor: Color
    private let foregroundColor: Color
    private let iconName: String
    
    init(_ type: NSWindow.ButtonType, _ isHovered: Binding<Bool>) {
        self.type = type
        self._isHovered = isHovered
        
        self.backgroundColor = switch type {
        case .closeButton: Color(hex: 0xFF5F57)
        case .miniaturizeButton: Color(hex: 0xFEBC2E)
        case .zoomButton: Color(hex: 0x28C840)
        default: .black
        }
        
        self.foregroundColor = switch type {
        case .closeButton: Color(hex: 0x990000)
        case .miniaturizeButton: Color(hex: 0x985600)
        case .zoomButton: Color(hex: 0x006100)
        default: .white
        }
        
        self.iconName = switch type {
        case .closeButton: "xmark"
        case .miniaturizeButton: "minus"
        case .zoomButton: "plus"
        default: "circle.fill"
        }
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(backgroundColor)
                .frame(width: 12)
            
            if isHovered {
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .bold()
                    .frame(width: 6)
                    .foregroundStyle(foregroundColor)
            }
        }
        .onTapGesture {
            if let window = NSApplication.shared.windows.first {
                switch type {
                case .closeButton: window.close()
                case .miniaturizeButton: window.miniaturize(nil)
                case .zoomButton: window.zoom(nil)
                default: let _: Any? = nil
                }
            }
        }
    }
}

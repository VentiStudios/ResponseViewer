//
//  ResponseView.swift
//  ResponseViewer
//
//  Created by YiZhiMCQiu on 8/9/25.
//

import SwiftUI

struct ResponseView: View {
    @EnvironmentObject private var dataManager: DataManager
    
    var body: some View {
        ZStack {
            Color(nsColor: .windowBackgroundColor)
            if let response = dataManager.response {
                ScrollView {
                    let text = JSONUtil.format(response.text) ?? response.text
                    let split = splitText(text)
                    LazyVStack(spacing: 0) {
                        // 不考虑重复情况
                        ForEach(split, id: \.self) { str in
                            Text(str)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .textSelection(.enabled)
                        }
                    }
                }
            }
        }
    }
    
    func splitText(_ text: String, linesPerChunk: Int = 64) -> [String] {
        let lines = text.split(separator: "\n", omittingEmptySubsequences: false)
        var chunks: [String] = []
        var currentChunk: [Substring] = []
        for (i, line) in lines.enumerated() {
            currentChunk.append(line)
            if (i + 1) % linesPerChunk == 0 {
                chunks.append(currentChunk.joined(separator: "\n"))
                currentChunk.removeAll()
            }
        }
        if !currentChunk.isEmpty {
            chunks.append(currentChunk.joined(separator: "\n"))
        }
        return chunks
    }
}

//
//  JSONHighlightView.swift
//  ResponseViewer
//
//  Created by YiZhiMCQiu on 8/9/25.
//

import SwiftUI

class JSONUtil {
    static func format(_ json: String) -> String? {
        let data = json.data(using: .utf8)!
        guard let object = try? JSONSerialization.jsonObject(with: data) else { return nil }
        guard let prettyData = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]) else { return nil }
        return String(data: prettyData, encoding: .utf8)
    }
    
    static func highlight(_ json: String) -> AttributedString {
        var result = AttributedString(json)
        
        func paint(_ pattern: String, color: Color) {
            guard let re = try? NSRegularExpression(pattern: pattern) else { return }
            let nsRange = NSRange(json.startIndex..<json.endIndex, in: json)
            re.enumerateMatches(in: json, range: nsRange) { m, _, _ in
                guard let m, let r = Range(m.range, in: json) else { return }
                if let lo = AttributedString.Index(r.lowerBound, within: result),
                   let hi = AttributedString.Index(r.upperBound, within: result) {
                    result[lo..<hi].foregroundColor = color
                }
            }
        }
        
        paint(#""([^"\\]|\\.)+"(?=\s*:)"#, color: .purple)
        paint(#""([^"\\]|\\.)*"(?!\s*:)"#, color: .blue)
        paint(#"-?\b\d+(\.\d+)?([eE][+-]?\d+)?\b"#, color: .orange)
        paint(#"\b(true|false|null)\b"#, color: .pink)
        
        return result
    }
}

struct AttributedText: View {
    let attributed: AttributedString
    var body: some View {
        Text(attributed)
    }
}

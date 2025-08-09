//
//  FocusManager.swift
//  ResponseViewer
//
//  Created by YiZhiMCQiu on 8/9/25.
//

import Foundation
import SwiftUI

enum FocusableView: Hashable {
    case location
}

class FocusManager: ObservableObject {
    static let shared: FocusManager = .init()
    @Published var focusedView: FocusableView?
    
    private init() {}
}

//
//  VisualEffectView.swift
//  
//
//  Created by 千葉和義 on 2023/03/19.
//

import SwiftUI

#if canImport(AppKit)
@available(macOS 10.15, *)
public struct VisualEffectView: NSViewRepresentable {
    public init() {}
    
    public func makeNSView(context: Context) -> NSVisualEffectView {
        let effectView = NSVisualEffectView()
        effectView.state = .active
        return effectView
    }
    
    public func updateNSView(_ nsView: NSVisualEffectView, context: Context) {}
}
#endif

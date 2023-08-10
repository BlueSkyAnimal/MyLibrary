//
//  VisualEffectView.swift
//  
//
//  Created by 千葉和義 on 2023/03/19.
//

import SwiftUI

@available(macOS 10.15, *)
@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(xrOS, unavailable)
struct VisualEffectView: NSViewRepresentable {
    func makeNSView(context: Context) -> NSVisualEffectView {
        let effectView = NSVisualEffectView()
        effectView.state = .active
        return effectView
    }
    
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {}
}

//
//  PresentedWindowManager.swift
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
public struct PresentationWindowManager: NSViewRepresentable {
    var action: (NSWindow) -> (Void)
    
    public func makeNSView(context: Context) -> some NSView {
        let view = NSView()
        view.layer?.backgroundColor = .clear
        DispatchQueue.main.async {
            if let window = view.window { action(window) }
        }
        return view
    }
    
    public func updateNSView(_ nsView: NSViewType, context: Context) {
        if let window = nsView.window { action(window) }
    }
}

//
//  ViewExtensions.swift
//  
//
//  Created by 千葉和義 on 2023/03/19.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public extension View {
    @ViewBuilder
    func transform(@ViewBuilder _ content: (Self) -> some View) -> some View {
        content(self)
    }
}

#if canImport(AppKit)
@available(macOS 10.15, *)
public extension View {
    @ViewBuilder
    func blurBackground(_ blur: Bool = true) -> some View {
        if blur {
            if #available(macOS 13.0, *) {
                self.background(VisualEffectView().ignoresSafeArea())
                    .scrollContentBackground(.hidden)
            } else if #available(macOS 11.0, *) {
                background(VisualEffectView().ignoresSafeArea())
            } else {
                background(VisualEffectView().edgesIgnoringSafeArea(.all))
            }
        } else {
            self
        }
    }
    
    @ViewBuilder
    func presentationWindowManager(_ action: @escaping (NSWindow) -> (Void)) -> some View {
        if #available(macOS 12.0, *) {
            background {
                PresentationWindowManager { action($0) }
            }
        } else {
            background(PresentationWindowManager { action($0) })
        }
    }
}
#endif

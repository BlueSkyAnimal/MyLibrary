//
//  ViewExtension.swift
//  
//
//  Created by 千葉和義 on 2023/03/19.
//

import SwiftUI

#if os(macOS)
@available(macOS 10.15, *)
public extension View {
    @ViewBuilder
    func blurBackground() -> some View {
        if #available(macOS 13.0, *) {
            self
                .background(VisualEffectView().ignoresSafeArea())
                .scrollContentBackground(.hidden)
        } else if #available(macOS 11.0, *) {
            background(VisualEffectView().ignoresSafeArea())
        } else {
            background(VisualEffectView().edgesIgnoringSafeArea(.all))
        }
    }
    
    @ViewBuilder
    func presentedWindowManager(_ action: @escaping (NSWindow) -> (Void)) -> some View {
        if #available(macOS 12.0, *) {
            background {
                PresentedWindowManager { action($0) }
            }
        } else {
            background(PresentedWindowManager { action($0) })
        }
    }
    
    @ViewBuilder
    func smartScroll() -> some View {
        if #available(iOS 16.4, macOS 13.3, tvOS 16.4, watchOS 9.4, *) {
            scrollBounceBehavior(.basedOnSize)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func hidden(_ isHidden: Bool) -> some View {
        if isHidden {
            hidden()
        } else {
            self
        }
    }
    
    @ViewBuilder
    func transform<Transform: View>(_ transform: (Self) -> Transform?) -> some View {
        if let transformed = transform(self) {
            transformed
        } else {
            self
        }
    }
}
#endif

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
}
#endif

//
//  BoolExtensions.swift
//
//
//  Created by BlueSkyAnimal on 2023/09/10.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, xrOS 1.0, *)
public extension Bool {
    @ViewBuilder
    func view(@ViewBuilder true: () -> some View) -> some View {
        if self {
            `true`()
        }
    }
    
    @ViewBuilder
    func view(@ViewBuilder true: () -> some View, @ViewBuilder false: () -> some View) -> some View {
        if self {
            `true`()
        } else {
            `false`()
        }
    }
}

//
//  SceneExtensions.swift
//  
//
//  Created by 千葉和義 on 2023/07/14.
//

import SwiftUI

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, visionOS 1.0, *)
public extension Scene {
    @SceneBuilder
    func transform(@SceneBuilder _ content: (Self) -> some Scene) -> some Scene {
        content(self)
    }
}

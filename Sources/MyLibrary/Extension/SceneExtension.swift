//
//  File.swift
//  
//
//  Created by 千葉和義 on 2023/07/14.
//

import SwiftUI

@available(iOS 13.0, macOS 11.0, tvOS 13.0, watchOS 6.0, xrOS 1.0, *)
extension Scene {
    @SceneBuilder
    func transform(@SceneBuilder _ content: (Self) -> some Scene) -> some Scene {
        content(self)
    }
}

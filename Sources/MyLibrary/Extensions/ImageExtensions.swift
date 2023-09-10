//
//  ImageExtensions.swift
//
//
//  Created by BlueSkyAnimal on 2023/09/07.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, xrOS 1.0, *)
public extension Image {
    #if canImport(UIKit)
    typealias SystemImage = UIImage
    #elseif canImport(AppKit)
    typealias SystemImage = NSImage
    #endif
    
    init?(data: Data) {
        guard let systemImage = SystemImage(data: data) else {
            return nil
        }
        
        #if canImport(UIKit)
        self.init(uiImage: systemImage)
        #elseif canImport(AppKit)
        self.init(nsImage: systemImage)
        #endif
    }
}

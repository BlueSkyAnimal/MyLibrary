//
//  ImageExtensions.swift
//
//
//  Created by BlueSkyAnimal on 2023/09/07.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public extension Image {
#if canImport(UIKit)
    typealias SystemImage = UIImage
#elseif canImport(AppKit)
    typealias SystemImage = NSImage
#endif
    
    public init?(data: Data) {
        guard let systemImage = SystemImage(data: data) else {
            return nil
        }
        
        self.init(system: systemImage)
    }
    
    public init(system: SystemImage) {
#if canImport(UIKit)
        self.init(uiImage: system)
#elseif canImport(AppKit)
        self.init(nsImage: system)
#endif
    }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension Image.SystemImage {
    private func calculateScaledSize(resolution: Int) -> (Double, Double) {
        let scaleFactor = sqrt(CGFloat(resolution) / (size.width * size.height))
        let finalWidth = min(size.width, size.width * scaleFactor)
        let finalHeight = min(size.height, size.height * scaleFactor)
        
        return (finalWidth, finalHeight)
    }
    
#if os(iOS)
    public func resized(resolution: Int = 1920 * 1080) async -> UIImage? {
        let (newWidth, newHeight) = calculateScaledSize(resolution: resolution)
        return await byPreparingThumbnail(ofSize: .init(width: newWidth, height: newHeight))
    }
#elseif os(macOS)
    public func resized(resolution: Int = 1920 * 1080) async -> NSImage? {
        let (newWidth, newHeight) = calculateScaledSize(resolution: resolution)
        
        let newImage = NSImage(size: .init(width: newWidth, height: newHeight))
        newImage.lockFocus()
        draw(in: NSRect(origin: .zero, size: .init(width: newWidth, height: newHeight)))
        defer { newImage.unlockFocus() }
        return newImage
    }
#endif
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension Data {
    public func resized(resolution: Int = 1920 * 1080) async -> Image.SystemImage? {
        guard let systemImage = Image.SystemImage(data: self) else {
            return nil
        }
        return await systemImage.resized(resolution: resolution)
    }
}


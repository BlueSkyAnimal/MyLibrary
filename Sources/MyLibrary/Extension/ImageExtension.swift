//
//  ImageExtension.swift
//  
//
//  Created by 千葉和義 on 2023/03/19.
//

import SwiftUI

#if os(iOS)
public typealias SystemImage = UIImage
#elseif os(macOS)
public typealias SystemImage = NSImage
#elseif os(tvOS)
public typealias SystemImage = UIImage
#elseif os(watchOS)
public typealias SystemImage = UIImage
#endif

@available(iOS 13.0, macOS 11.0, tvOS 13.0, watchOS 6.0, *)
public extension Image {
    init(data: Data) {
        if let systemImage = SystemImage(data: data) {
#if os(iOS)
            self.init(uiImage: systemImage)
#elseif os(macOS)
            self.init(nsImage: systemImage)
#elseif os(tvOS)
            self.init(uiImage: systemImage)
#elseif os(watchOS)
            self.init(uiImage: systemImage)
#endif
        } else {
            self.init(systemName: "photo")
        }
    }
}

//
//  StringExtensions.swift
//
//
//  Created by 千葉和義 on 2023/03/19.
//

import SwiftUI

public extension CustomStringConvertible {
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    func copyToClipboard() {
#if canImport(UIKit)
        UIPasteboard.general.string = self.description
#elseif canImport(AppKit)
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(self.description, forType: .string)
#endif
    }
}

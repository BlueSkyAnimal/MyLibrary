//
//  StringExtensions.swift
//
//
//  Created by 千葉和義 on 2023/03/19.
//

import SwiftUI

public extension String {
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    func copy() {
#if canImport(UIKit)
        UIPasteboard.general.string = self
#elseif canImport(AppKit)
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(self, forType: .string)
#endif
    }
}

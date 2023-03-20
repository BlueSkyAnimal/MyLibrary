//
//  StringExtension.swift
//  
//
//  Created by 千葉和義 on 2023/03/19.
//

import SwiftUI

public extension String {
    func copy() {
#if os(iOS)
        UIPasteboard.general.string = self
#elseif os(macOS)
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(self, forType: .string)
#endif
    }
}

//
//  AppDelegate.swift
//  
//
//  Created by 千葉和義 on 2023/03/20.
//

import SwiftUI

#if os(macOS)
public class AppDelegate: NSObject, NSApplicationDelegate {
    public func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
#endif

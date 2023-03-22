//
//  RoundedIconLabel.swift
//  
//
//  Created by 千葉和義 on 2023/03/19.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct RoundedIconLabel: View {
    var foreground: Color
    var background: Color
    var systemIcon: String
    var title: String
    
    public init(foreground: Color, background: Color, systemIcon: String, title: String) {
        self.foreground = foreground
        self.background = background
        self.systemIcon = systemIcon
        self.title = title
    }
    
    public var body: some View {
        HStack {
            if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
                Image(systemName: systemIcon)
                    .resizable()
                    .foregroundColor(foreground)
#if os(macOS)
                    .shadow(color: .black.opacity(0.3), radius: 0.5, y: 0.2)
#endif
                    .padding(3)
                    .frame(width: 20, height: 20)
#if os(macOS)
                    .background(background.gradient)
#endif
                    .cornerRadius(5)
                    .shadow(color: .black.opacity(0.2), radius: 1, y: 0.5)
            } else if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
                Image(systemName: systemIcon)
                    .resizable()
                    .foregroundColor(foreground)
#if os(macOS)
                    .shadow(color: .black.opacity(0.3), radius: 0.5, y: 0.2)
#endif
                    .padding(3)
                    .frame(width: 20, height: 20)
                    .background(background)
                    .cornerRadius(5)
                    .shadow(color: .black.opacity(0.2), radius: 1, y: 0.5)
            }
            Text(title)
        }
    }
}

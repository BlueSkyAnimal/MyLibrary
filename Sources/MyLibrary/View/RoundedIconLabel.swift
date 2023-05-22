//
//  RoundedIconLabel.swift
//  
//
//  Created by 千葉和義 on 2023/03/19.
//

import SwiftUI

@available(iOS 13.0, macOS 11.0, tvOS 13.0, watchOS 6.0, *)
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
                plain
#if os(iOS)
                    .background(background)
#elseif os(macOS)
                    .background(background.gradient)
#endif
                    .cornerRadius(5)
#if os(macOS)
                    .shadow(color: .black.opacity(0.2), radius: 1, y: 0.5)
#endif
            } else {
                plain
                    .background(background)
                    .cornerRadius(5)
#if os(macOS)
                    .shadow(color: .black.opacity(0.2), radius: 1, y: 0.5)
#endif
            }
            Text(title)
        }
    }
    
    private var plain: some View {
        Image(systemName: systemIcon)
            .resizable()
            .scaledToFit()
            .foregroundColor(foreground)
#if os(macOS)
            .shadow(color: .black.opacity(0.3), radius: 0.5, y: 0.2)
#endif
            .padding(3)
            .frame(width: 20, height: 20)
    }
}

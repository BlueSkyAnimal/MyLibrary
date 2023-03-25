//
//  ColorProgressView.swift
//  
//
//  Created by 千葉和義 on 2023/03/20.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct ColorProgressView: View {
    @State var front: Double = 0
    @State var back: Double = 0
    var tint: Color
    var width: Double
    var size: Double
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func progress() {
        front = 0
        back = 0
        withAnimation(.easeInOut(duration: 1)) {
            front = 1
        }
        withAnimation(.easeInOut(duration: 0.5).delay(0.5)) {
            back = 1
        }
    }
    
    public init(tint: Color = .accentColor, width: Double = 5, size: Double = 50) {
        self.tint = tint
        self.width = width
        self.size = size
    }
    
    public var body: some View {
        ZStack {
            Circle()
                .trim(from: back, to: front)
                .stroke(tint, style: .init(lineWidth: width, lineCap: .round))
                .rotationEffect(.degrees(-90))
        }
        .frame(width: size, height: size)
        .padding()
        .onAppear {
            progress()
        }
        .onReceive(timer) { _ in
            progress()
        }
    }
}

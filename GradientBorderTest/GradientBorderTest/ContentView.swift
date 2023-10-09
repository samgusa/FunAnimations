//
//  ContentView.swift
//  GradientBorderTest
//
//  Created by Sam Greenhill on 10/8/23.
//

import SwiftUI

struct ContentView: View {
    @State private var rotation: CGFloat = 0.0
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(width: 260, height: 336)
                .foregroundColor(.black)

            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(width: 130, height: 500)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.purple]), startPoint: .top, endPoint: .bottom))
                .rotationEffect(.degrees(rotation))
                .mask {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(lineWidth: 7)
                        .frame(width: 256, height: 336)
                }
            Text("CARD")
                .font(.largeTitle)
                .foregroundStyle(.white)
        }
        .onAppear {
            withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        }
    }
}

#Preview {
    ContentView()
}

//
//  DarkCard.swift
//  GradientBorderTest
//
//  Created by Sam Greenhill on 10/8/23.
//

import SwiftUI

struct DarkCard: View {
    @State private var rotation: CGFloat = 0.0

    var body: some View {
        ZStack {
            Color.gray
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(width: 260, height: 340)
                .foregroundColor(.black)
                .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 10)

            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(width: 500, height: 200)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.4), Color.yellow, Color.yellow, Color.yellow.opacity(0.4)]), startPoint: .top, endPoint: .bottom))
                .rotationEffect(.degrees(rotation))
                .mask {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(lineWidth: 3)
                        .frame(width: 256, height: 336)
                }
            Text("CARD")
                .font(.largeTitle)
                .foregroundStyle(.white)
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        }
    }
}

#Preview {
    DarkCard()
}

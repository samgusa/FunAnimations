//
//  ColorsCard.swift
//  GradientBorderTest
//
//  Created by Sam Greenhill on 10/9/23.
//

import SwiftUI

struct ColorsCard: View {
    @State private var rotation: CGFloat = 0.0
    var body: some View {
        ZStack {
            Color.gray

            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(width: 440, height: 430)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .top, endPoint: .bottom))
                .rotationEffect(.degrees(rotation))
                .mask {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(lineWidth: 3)
                        .frame(width: 250, height: 335)
                        .blur(radius: 10)
                }

            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(width: 260, height: 336)
                .foregroundColor(.black)


            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(width: 500, height: 440)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .top, endPoint: .bottom))
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
    ColorsCard()
}

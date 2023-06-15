//
//  NewShimmerView.swift
//  ShimmerTest
//
//  Created by Sam Greenhill on 5/3/23.
//

import SwiftUI

struct NewShimmerView: View {
    @State private var startAnimation: Bool = true
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Hello World")
                    .font(.title)
                    .fontWeight(.black)
                    .shimmer(.init(tint: .white.opacity(0.5), highlight: .white, blur: 5), animation: $startAnimation)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(.red.gradient)
                    }
                HStack(spacing: 15) {
                    ForEach(["suit.heart.fill", "box.truck.badge.clock.fill", "sun.max.trianglebadge.exclamationmark.fill"], id: \.self) { sfImage in
                        Image(systemName: sfImage)
                            .font(.title)
                            .fontWeight(.black)
                            .shimmer(.init(tint: .white.opacity(0.4), highlight: .white, blur: 5), animation: $startAnimation)
                            .frame(width: 40, height: 40)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .fill(.indigo.gradient)
                            }
                    }
                }
                // Another Example
                HStack {
                    Circle()
                        .frame(width: 55, height: 55)

                    VStack(alignment: .leading, spacing: 6) {
                        RoundedRectangle(cornerRadius: 4)
                            .frame(height: 10)

                        RoundedRectangle(cornerRadius: 4)
                            .frame(height: 10)
                            .padding(.trailing, 50)

                        RoundedRectangle(cornerRadius: 4)
                            .frame(height: 10)
                            .padding(.trailing, 100)
                    }
                }
                .padding(15)
                .padding(.horizontal, 30)
                .shimmer(.init(tint: .gray.opacity(0.3), highlight: .white, blur: 5), animation: $startAnimation)

                Button {
                    startAnimation.toggle()
                } label: {
                    Text("Press")
                }

            }
            .navigationTitle("Shimmer Effect")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Help") {
                        print("Help tapped!")
                    }
                }
            }
        }
    }
}

/// Shimmer Effect Custom View Modifier

extension View {
    @ViewBuilder
    func shimmer(_ config: ShimmerConfig, animation: Binding<Bool>) -> some View {
        self
            .modifier(ShimmerEffectHelper(config: config, startAnimation: animation))
    }
}

// Shimmer Effect Helper
fileprivate struct ShimmerEffectHelper: ViewModifier {
    // Shimmer Config
    var config: ShimmerConfig
    // Animation Properties
    @State private var moveTo: CGFloat = -0.7
    @Binding var startAnimation: Bool
    func body(content: Content) -> some View {
        content
        // Adding shimmer Animation with the help of Masking Modifier
        // hiding the normal one and adding shimmer on instead
            .hidden()
            .overlay {
                // Changing tint color
                Rectangle()
                    .fill(config.tint)
                    .mask {
                        content
                    }
                    .overlay {
                        /// Shimmer
                        GeometryReader {
                            let size = $0.size
                            let extraOffset = size.height / 2.5
                            Rectangle()
                                .fill(config.highlight)
                                .mask {
                                    Rectangle()
                                    /// Gradient for glowing at the center
                                        .fill( // Color here is useless since it's a masking view
                                            .linearGradient(colors: [.white.opacity(0), config.highlight.opacity(config.highlightOpacity), .white.opacity(0)], startPoint: .top, endPoint: .bottom)
                                        )
                                    // Adding Blur
                                        .blur(radius: config.blur)
                                    //Can add another property in the config for blend mode and use it after the mask if you need more customization.  EG: .mask {}.blendMode()
                                    // Rotating (Degree: Your choice of Wish)
                                        .rotationEffect(.init(degrees: -70))
                                    //Moving to the start
                                        .offset(x: moveTo > 0 ? extraOffset : -extraOffset)
                                        .offset(x: size.width * moveTo)
                                }
                        }
                        // Mask with the content
                        .mask {
                            if startAnimation {
                                content
                            }
                        }
                    }
                // Animating Movement
                    .onAppear {
                        // sometimes a forever animation called inside an onappear will cause animation glitches, especially when using inside NavigationView; to avoid that, simply wwrap it inside a dispatchQueue.
                        DispatchQueue.main.async {
                            //startAnimation.toggle()
                            moveTo = 0.7
                        }
                    }
                    .animation(.linear(duration: config.speed).repeatForever(autoreverses: false), value: moveTo)
            }
    }
}

//Shimmer Config -- contains all the shimmer animation properties
struct ShimmerConfig {
    var tint: Color
    var highlight: Color
    var blur: CGFloat = 0
    var highlightOpacity: CGFloat = 1
    var speed: CGFloat = 2
}

struct NewShimmerView_Previews: PreviewProvider {
    static var previews: some View {
        NewShimmerView()
    }
}
